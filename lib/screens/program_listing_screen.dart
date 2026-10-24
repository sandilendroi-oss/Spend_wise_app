import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'program_details_screen.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  String filter = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final programs = const [
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter by category and search query
    final list = programs.where((p) {
      final matchesCategory = filter == 'All' || p['category'] == filter;
      final matchesSearch = (p['title'] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (p['provider'] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Programs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppColors.brandGradient)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search programs...',
                prefixIcon: const Icon(Icons.search, color: AppColors.orangeColor),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.cardWhiteColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: ['All', 'Leadership', 'Tech Skills', 'Wellness', 'Career'].map((cat) {
                final isSel = filter == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSel,
                    onSelected: (_) => setState(() => filter = cat),
                    selectedColor: AppColors.pinkColor,
                    backgroundColor: AppColors.cardWhiteColor,
                    labelStyle: TextStyle(color: isSel ? Colors.white : AppColors.textColor, fontWeight: FontWeight.w600),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: list.isEmpty
                ? const Center(
                    child: Text('No programs found', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final p = list[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: AppColors.cardWhiteColor, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.network(
                                    p['image']! as String,
                                    height: 130,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    // Optimization: Cache image dimensions to reduce memory overhead and stuttering
                                    cacheWidth: 800,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        height: 130,
                                        color: Colors.grey.shade200,
                                        child: const Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.orangeColor),
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      height: 130,
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.broken_image, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(color: AppColors.orangeColor, borderRadius: BorderRadius.circular(12)),
                                    child: Text(p['category']! as String, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p['title']! as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor)),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.pinkColor),
                                      const SizedBox(width: 6),
                                      Text(p['date']! as String, style: TextStyle(fontSize: 13, color: AppColors.textColor.withValues(alpha: 0.7))),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(10)),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProgramDetailsScreen(data: p))),
                                      child: const Text('View Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}