import 'package:speed_wise_app/models/json_helpers.dart';

/// One program (course / workshop) coming from the Mock API.
///
/// The field names match the data that is already hardcoded in
/// `program_listing_screen.dart`. They are PROPOSED API field names until the
/// team confirms the real Mock API response.
class Program {
  final String id;
  final String title;
  final String date;
  final String category;
  final String image;
  final String provider;
  final String description;
  final String schedule;
  final List<String> eligibility;

  const Program({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    required this.image,
    required this.provider,
    required this.description,
    required this.schedule,
    required this.eligibility,
  });

  /// Builds a [Program] from one JSON object.
  ///
  /// Only `title` is required. Every other field falls back to an empty
  /// value, so a half-filled record cannot crash the UI.
  /// Throws a [FormatException] if `title` is missing or empty.
  factory Program.fromJson(Map<String, dynamic> json) {
    final title = readString(json['title']);
    if (title == null || title.isEmpty) {
      throw const FormatException(
        'Program is missing the required "title" field',
      );
    }
    return Program(
      id: readString(json['id']) ?? '',
      title: title,
      date: readString(json['date']) ?? '',
      category: readString(json['category']) ?? '',
      image: readString(json['image']) ?? '',
      provider: readString(json['provider']) ?? '',
      description: readString(json['description']) ?? '',
      schedule: readString(json['schedule']) ?? '',
      eligibility: readStringList(json['eligibility']),
    );
  }

  /// Converts the program back to JSON (useful for logging or POST/PUT later).
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date,
    'category': category,
    'image': image,
    'provider': provider,
    'description': description,
    'schedule': schedule,
    'eligibility': eligibility,
  };

  /// Returns the same Map shape the existing UI already uses.
  ///
  /// `ProgramDetailsScreen(data: ...)` expects a `Map<String, dynamic>` with
  /// the keys title, date, category, image, provider, description, schedule
  /// and eligibility. Passing `program.toDetailsMap()` lets the details screen
  /// keep working without any change.
  Map<String, dynamic> toDetailsMap() => {
    'title': title,
    'date': date,
    'category': category,
    'image': image,
    'provider': provider,
    'description': description,
    'schedule': schedule,
    'eligibility': eligibility,
  };
}
