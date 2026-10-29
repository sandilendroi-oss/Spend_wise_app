import 'package:flutter/material.dart';
import 'package:speed_wise_app/screens/registration_feedback_screen.dart';
import '../models/program.dart';
import '../theme/app_colors.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final Program program;
  const ProgramDetailsScreen({super.key, required this.program});

  TextStyle get _heading => const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor);
  TextStyle get _body => TextStyle(fontSize: 14, color: AppColors.textColor.withValues(alpha: 0.8));
  final Program program;
  const ProgramDetailsScreen({super.key, required this.program});

  TextStyle get _heading => const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor);
  TextStyle get _body => TextStyle(fontSize: 14, color: AppColors.textColor.withValues(alpha: 0.8));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Program Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppColors.brandGradient)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              program.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              cacheWidth: 1000,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator(color: AppColors.orangeColor)),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey.shade300,
                child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(program.title,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.orangeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Upcoming',
                            style: TextStyle(color: AppColors.orangeColor, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Provider: ${program.provider}',
                      style: const TextStyle(color: AppColors.pinkColor, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(12)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      // Member 3: navigate to the registration form, passing `program`.
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormsHubScreen(program: program),
                          ),
                        );
                      },
                      child: const Text('Register',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Program Description', style: _heading),
                  const SizedBox(height: 6),
                  Text(program.description, style: _body),
                  const SizedBox(height: 16),
                  Text('Schedule', style: _heading),
                  const SizedBox(height: 6),
                  Text(program.schedule, style: _body),
                  const SizedBox(height: 16),
                  Text('Eligibility Criteria', style: _heading),
                  const SizedBox(height: 6),
                  ...program.eligibility.map((e) => Text('• $e', style: _body)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
