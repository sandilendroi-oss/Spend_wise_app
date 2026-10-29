import '../models/program.dart';

class ProgramService {
  Future<List<Program>> fetchPrograms() async {
    await Future.delayed(const Duration(seconds: 2)); // fake network delay
   
    return _mock.map(Program.fromJson).toList();
  }

  static final List<Map<String, dynamic>> _mock = [
    {
      'title': 'Leadership & Professional Growth',
      'date': 'May 5, 2025 – May 26, 2025',
      'category': 'Leadership',
      'image': 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=400&q=80',
      'provider': 'Excelerate Learning Center',
      'description': 'Build essential leadership skills, improve communication, and prepare for future career opportunities.',
      'schedule': 'Mon, Wed, Fri • 10:00 AM – 12:00 PM',
      'eligibility': ['Aged 18+', 'Currently enrolled in a program', 'Motivated to grow professionally'],
    },
    {
      'title': 'Digital Skills Workshop',
      'date': 'May 12, 2025',
      'category': 'Tech Skills',
      'image': 'https://images.unsplash.com/photo-1531482615713-2afd69097998?auto=format&fit=crop&w=400&q=80',
      'provider': 'Excelerate Tech Hub',
      'description': 'Master foundational digital skills, modern software tools, and workflow automation.',
      'schedule': 'Tue, Thu • 2:00 PM – 4:00 PM',
      'eligibility': ['Basic computer literacy', 'Aged 16+'],
    },
    {
      'title': 'Wellness & Resilience',
      'date': 'May 20, 2025',
      'category': 'Wellness',
      'image': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=400&q=80',
      'provider': 'Excelerate Life Academy',
      'description': 'Learn effective stress-management techniques and mental resilience strategies.',
      'schedule': 'Saturdays • 11:00 AM – 1:00 PM',
      'eligibility': ['Open to all learners'],
    },
    {
      'title': 'Career Development Seminar',
      'date': 'May 28, 2025',
      'category': 'Career',
      'image': 'https://images.unsplash.com/photo-1531497865144-0464ef8fb9a9?auto=format&fit=crop&w=400&q=80',
      'provider': 'Excelerate Career Center',
      'description': 'Gain practical tips on resume building, interviewing, and networking.',
      'schedule': 'Fridays • 3:00 PM – 5:00 PM',
      'eligibility': ['Job seekers and students'],
    },
  ];
}
