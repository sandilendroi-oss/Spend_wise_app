// TEMPORARY STUB - replace with Member 1's Program model once it is pushed.
// Field names match what the screens currently use; if Member 1's JSON keys
// differ, only fromJson needs to change.
class Program {
  final String title;
  final String date;
  final String category;
  final String image;
  final String provider;
  final String description;
  final String schedule;
  final List<String> eligibility;

  const Program({
    required this.title,
    required this.date,
    required this.category,
    required this.image,
    required this.provider,
    required this.description,
    required this.schedule,
    required this.eligibility,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        title: json['title'] as String? ?? '',
        date: json['date'] as String? ?? '',
        category: json['category'] as String? ?? '',
        image: json['image'] as String? ?? '',
        provider: json['provider'] as String? ?? '',
        description: json['description'] as String? ?? '',
        schedule: json['schedule'] as String? ?? '',
        eligibility: List<String>.from(json['eligibility'] as List? ?? const []),
      );
}
