import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:speed_wise_app/models/event.dart';
import 'package:speed_wise_app/models/program.dart';
import 'package:speed_wise_app/services/api_service.dart';

const _base = 'https://example.test/api';

/// Builds an ApiService whose HTTP calls are answered by [handler],
/// so no real internet or server is needed.
ApiService _service(
  Future<http.Response> Function(http.Request) handler, {
  Duration? timeout,
}) {
  return ApiService(
    client: MockClient(handler),
    baseUrl: _base,
    timeout: timeout,
  );
}

http.Response _json(String body, [int status = 200]) => http.Response(
  body,
  status,
  headers: {'content-type': 'application/json; charset=utf-8'},
);

const _programsJson = '''
[
  {
    "id": "1",
    "title": "Digital Skills Workshop",
    "date": "May 12, 2025",
    "category": "Tech Skills",
    "image": "https://example.test/a.png",
    "provider": "Excelerate Tech Hub",
    "description": "Learn digital skills.",
    "schedule": "Tue, Thu",
    "eligibility": ["Aged 16+", "Basic computer literacy"]
  },
  {
    "id": 2,
    "title": "Wellness"
  }
]
''';

const _eventsJson = '''
[
  {
    "id": "10",
    "title": "Career Fair",
    "description": "Meet employers.",
    "date": "June 1, 2025",
    "location": "Main Hall",
    "programId": "1"
  },
  {"id": "11", "title": "Open Day"}
]
''';

void main() {
  group('Models', () {
    test('Program.fromJson reads all fields', () {
      final p = Program.fromJson({
        'id': '1',
        'title': 'T',
        'date': 'D',
        'category': 'C',
        'image': 'I',
        'provider': 'P',
        'description': 'Desc',
        'schedule': 'S',
        'eligibility': ['a', 'b'],
      });
      expect(p.title, 'T');
      expect(p.eligibility, ['a', 'b']);
    });

    test('Program.fromJson handles missing optional fields and numeric id', () {
      final p = Program.fromJson({'id': 5, 'title': 'Only title'});
      expect(p.id, '5');
      expect(p.category, '');
      expect(p.eligibility, isEmpty);
    });

    test('Program.fromJson accepts a single string as eligibility', () {
      final p = Program.fromJson({'title': 'T', 'eligibility': 'Open to all'});
      expect(p.eligibility, ['Open to all']);
    });

    test('Program.fromJson throws when title is missing', () {
      expect(() => Program.fromJson({'id': '1'}), throwsFormatException);
    });

    test('Program.toDetailsMap has the keys ProgramDetailsScreen needs', () {
      final map = Program.fromJson({'title': 'T'}).toDetailsMap();
      for (final key in [
        'title',
        'date',
        'category',
        'image',
        'provider',
        'description',
        'schedule',
        'eligibility',
      ]) {
        expect(map.containsKey(key), isTrue, reason: 'missing key $key');
      }
      expect(map['eligibility'], isA<List<String>>());
      expect(map['image'], isA<String>());
    });

    test('Event.fromJson handles optional programId', () {
      final withId = Event.fromJson({'title': 'E', 'programId': 3});
      final without = Event.fromJson({'title': 'E'});
      expect(withId.programId, '3');
      expect(without.programId, isNull);
    });

    test('Event.fromJson throws when title is missing', () {
      expect(() => Event.fromJson({'id': '1'}), throwsFormatException);
    });
  });

  group('ApiService success', () {
    test('fetchPrograms returns typed Program objects', () async {
      late Uri requested;
      final api = _service((req) async {
        requested = req.url;
        return _json(_programsJson);
      });

      final programs = await api.fetchPrograms();

      expect(requested.toString(), '$_base/programs');
      expect(programs, hasLength(2));
      expect(programs.first, isA<Program>());
      expect(programs.first.title, 'Digital Skills Workshop');
      expect(programs.first.eligibility, hasLength(2));
      expect(programs[1].id, '2');
    });

    test('fetchEvents returns typed Event objects', () async {
      late Uri requested;
      final api = _service((req) async {
        requested = req.url;
        return _json(_eventsJson);
      });

      final events = await api.fetchEvents();

      expect(requested.toString(), '$_base/events');
      expect(events, hasLength(2));
      expect(events.first.location, 'Main Hall');
      expect(events.first.programId, '1');
      expect(events[1].programId, isNull);
    });

    test('an empty JSON list is a valid empty result', () async {
      final api = _service((_) async => _json('[]'));
      expect(await api.fetchPrograms(), isEmpty);
    });
  });

  group('ApiService errors', () {
    test('HTTP 404 throws ApiException with status code', () async {
      final api = _service((_) async => _json('{"error":"nf"}', 404));
      expect(
        api.fetchPrograms(),
        throwsA(
          isA<ApiException>().having((e) => e.statusCode, 'statusCode', 404),
        ),
      );
    });

    test('HTTP 500 throws ApiException with status code', () async {
      final api = _service((_) async => _json('oops', 500));
      expect(
        api.fetchEvents(),
        throwsA(
          isA<ApiException>().having((e) => e.statusCode, 'statusCode', 500),
        ),
      );
    });

    test('ClientException is reported as a network problem', () async {
      final api = _service((_) async => throw http.ClientException('offline'));
      expect(
        api.fetchPrograms(),
        throwsA(
          isA<ApiException>().having(
            (e) => e.message,
            'message',
            contains('Network problem'),
          ),
        ),
      );
    });

    test('SocketException (no internet) becomes ApiException', () async {
      final api = _service(
        (_) async => throw const SocketException('no internet'),
      );
      expect(api.fetchPrograms(), throwsA(isA<ApiException>()));
    });

    test('a slow server triggers the timeout', () async {
      final api = _service((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 300));
        return _json('[]');
      }, timeout: const Duration(milliseconds: 50));
      expect(
        api.fetchPrograms(),
        throwsA(
          isA<ApiException>().having(
            (e) => e.message,
            'message',
            contains('too long'),
          ),
        ),
      );
    });

    test('invalid JSON throws ApiException', () async {
      final api = _service((_) async => _json('this is not json'));
      expect(
        api.fetchPrograms(),
        throwsA(
          isA<ApiException>().having(
            (e) => e.message,
            'message',
            contains('invalid JSON'),
          ),
        ),
      );
    });

    test('a JSON object instead of a list throws ApiException', () async {
      final api = _service((_) async => _json('{"data": []}'));
      expect(
        api.fetchPrograms(),
        throwsA(
          isA<ApiException>().having(
            (e) => e.message,
            'message',
            contains('expected a JSON list'),
          ),
        ),
      );
    });

    test('a list item that is not an object throws ApiException', () async {
      final api = _service((_) async => _json('["a", "b"]'));
      expect(api.fetchEvents(), throwsA(isA<ApiException>()));
    });

    test('an item without a title throws ApiException', () async {
      final api = _service((_) async => _json('[{"id": "1"}]'));
      expect(
        api.fetchPrograms(),
        throwsA(
          isA<ApiException>().having(
            (e) => e.message,
            'message',
            contains('title'),
          ),
        ),
      );
    });

    test(
      'the placeholder base URL is rejected without any network call',
      () async {
        var called = false;
        final api = ApiService(
           baseUrl: 'https://YOUR_PROJECT_ID.mockapi.io/api/v1',
          client: MockClient((_) async {
            called = true;
            return _json('[]');
          }),
        );
        await expectLater(api.fetchPrograms(), throwsA(isA<ApiException>()));
        expect(called, isFalse);
      },
    );
  });
}
