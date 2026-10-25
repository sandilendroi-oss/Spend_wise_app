import 'package:flutter/material.dart';
import '../models/program.dart';
import '../services/program_service.dart';
import '../theme/app_colors.dart';
import 'program_details_screen.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  final ProgramService _service = ProgramService();
  late Future<List<Program>> _programsFuture;

  String filter = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Create the future ONCE here, never inside build(), otherwise the
    // API is called again on every rebuild (every keystroke in search).
    _programsFuture = _service.fetchPrograms();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload() {
    setState(() {
      _programsFuture = _service.fetchPrograms();
    });
  }

  Future<void> _refresh() async {
    _reload();
    try {
      await _programsFuture;
    } catch (_) {
      // The FutureBuilder shows the error state.
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder<List<Program>>(
              future: _programsFuture,
              builder: (context, snapshot) {
                // 1. Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.orangeColor),
                  );
                }

                // 2. Error
                if (snapshot.hasError) {
                  return _ErrorView(
                    message: snapshot.error.toString().replaceFirst('Exception: ', ''),
                    onRetry: _reload,
                  );
                }

                // 3. Data (filter + search happen on the loaded list)
                final all = snapshot.data ?? [];
                final list = all.where((p) {
                  final q = searchQuery.toLowerCase();
                  final matchesCategory = filter == 'All' || p.category == filter;
                  final matchesSearch = p.title.toLowerCase().contains(q) || p.provider.toLowerCase().contains(q);
                  return matchesCategory && matchesSearch;
                }).toList();

                if (list.isEmpty) {
                  return const Center(
                    child: Text('No programs found', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.orangeColor,
                  onRefresh: _refresh,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    itemBuilder: (context, i) => _ProgramCard(
                      program: list[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProgramDetailsScreen(program: list[i])),
                      ),
                    ),
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

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 56, color: AppColors.pinkColor),
            const SizedBox(height: 12),
            const Text('Could not load programs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor)),
            const SizedBox(height: 6),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textColor.withValues(alpha: 0.7))),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final Program program;
  final VoidCallback onTap;
  const _ProgramCard({required this.program, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
                  program.image,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
                  child: Text(program.category, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(program.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.pinkColor),
                    const SizedBox(width: 6),
                    Text(program.date, style: TextStyle(fontSize: 13, color: AppColors.textColor.withValues(alpha: 0.7))),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                    onPressed: onTap,
                    child: const Text('View Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
