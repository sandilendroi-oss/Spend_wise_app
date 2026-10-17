import 'package:flutter/material.dart';
import 'package:speed_wise_app/theme/app_colors.dart';
import 'category_icon.dart';


class ExpenseTile extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String categoryName;
  final String amount;

  const ExpenseTile({
    super.key,
    required this.icon,
    this.backgroundColor = AppColors.lightBackgroundColor,
    this.iconColor = const Color(0xFF25834A),
    required this.categoryName,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CategoryIcon(
        icon: icon,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
      ),
      title: Text(
        categoryName,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        '\$$amount',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );  
}
  }