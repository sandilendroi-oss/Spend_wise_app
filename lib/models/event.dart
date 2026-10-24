import 'package:speed_wise_app/models/json_helpers.dart';

/// One event coming from the Mock API.
///
/// IMPORTANT: no event structure exists anywhere in the repo or the team
/// chat yet. These fields (id, title, description, date, location, programId)
/// are a PROPOSAL. Update this class once the team agrees on the real
/// response shape.
class Event {
  final String id;
  final String title;
  final String description;
  final String date;
  final String location;

  /// Optional link to a program, if the event belongs to one.
  final String? programId;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    this.programId,
  });

  /// Builds an [Event] from one JSON object.
  ///
  /// Only `title` is required. Throws a [FormatException] if it is missing.
  factory Event.fromJson(Map<String, dynamic> json) {
    final title = readString(json['title']);
    if (title == null || title.isEmpty) {
      throw const FormatException(
        'Event is missing the required "title" field',
      );
    }
    final programId = readString(json['programId']);
    return Event(
      id: readString(json['id']) ?? '',
      title: title,
      description: readString(json['description']) ?? '',
      date: readString(json['date']) ?? '',
      location: readString(json['location']) ?? '',
      programId: (programId == null || programId.isEmpty) ? null : programId,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'location': location,
    if (programId != null) 'programId': programId,
  };
}
