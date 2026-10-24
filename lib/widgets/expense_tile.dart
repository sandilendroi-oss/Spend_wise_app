// import 'package:flutter/material.dart';
// import 'package:speed_wise_app/theme/app_colors.dart';
// import 'category_icon.dart';


// class ExpenseTile extends StatelessWidget {
//   final IconData icon;
//   final Color backgroundColor;
//   final Color iconColor;
//   final String categoryName;
//   final String amount;

//   const ExpenseTile({
//     super.key,
//     required this.icon,
//     this.backgroundColor = AppColors.lightBackgroundColor,
//     this.iconColor = const Color(0xFF25834A),
//     required this.categoryName,
//     required this.amount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CategoryIcon(
//         icon: icon,
//         backgroundColor: backgroundColor,
//         iconColor: iconColor,
//       ),
//       title: Text(
//         categoryName,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       trailing: Text(
//         '\$$amount',
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );  
// }
//   }
import 'package:flutter/material.dart';
import 'package:speed_wise_app/theme/app_colors.dart';
import 'category_icon.dart';

class ExpenseTile extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String categoryName;
  final String amount;
  /// Optional second line under [categoryName] (e.g. "Groceries").
  final String? subtitle;
  final VoidCallback? onTap;
  const ExpenseTile({
    super.key,
    required this.icon,
    this.backgroundColor = AppColors.backgroundColor,
    this.iconColor = const Color(0xFF25834A),
    required this.categoryName,
    required this.amount,
    this.subtitle,
    this.onTap,
  });

  /// "84.20" -> "$84.20", "-84.20" -> "-$84.20"
  String get _formattedAmount {
    if (amount.startsWith('-')) {
      return '-\$${amount.substring(1)}';
    }
    return '\$$amount';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textColor,
              ),
            ),
      trailing: Text(
        _formattedAmount,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );  
   }
  }