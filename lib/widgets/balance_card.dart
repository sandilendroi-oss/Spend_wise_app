import 'package:flutter/material.dart';
import 'package:speed_wise_app/theme/app_colors.dart';

class BalanceCard extends StatelessWidget {
  final String amount;

  const BalanceCard({
    super.key,
    required this.amount,
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
            Text(
              "Total Balance",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$$amount',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}