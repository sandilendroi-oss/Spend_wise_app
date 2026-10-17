import 'package:flutter/material.dart';
import 'package:speed_wise_app/theme/app_colors.dart';
import 'category_icon.dart';

class BudgetCard extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String categoryName;
  final String percentageSubtitle; // e.g., "34.9% of today"
  final String spentAmount;      // e.g., "42.10"
  final String limitAmount;      // e.g., "50"
  final String remainingAmount;  // e.g., "$7.90 remaining"
  final double progressValue;    // e.g., 0.349 (from 0.0 to 1.0)

  const BudgetCard({
    super.key,
    required this.icon,
    this.backgroundColor = AppColors.lightBackgroundColor,
    this.iconColor = const Color(0xFF25834A),
    required this.categoryName,
    required this.percentageSubtitle,
    required this.spentAmount,
    required this.limitAmount,
    required this.remainingAmount,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon, Category Info (Left) & Amounts (Right)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CategoryIcon(
                      icon: icon,
                      backgroundColor: backgroundColor,
                      iconColor: iconColor,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          percentageSubtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Right side amounts
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$$spentAmount',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'of \$$limitAmount budget',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Progress Indicator line
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progressValue.clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: AppColors.lightBackgroundColor,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.darkGreenColor),
              ),
            ),
            const SizedBox(height: 12),
            
            // Bottom Remaining Text
            Text(
              remainingAmount,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGreenColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}