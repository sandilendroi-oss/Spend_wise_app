import 'package:flutter/material.dart';

/// Formats a number as dollars, e.g. 42.1 -> $42.10
String formatMoney(double v) => '\$${v.toStringAsFixed(2)}';

/// One spending category with its amount spent and budget.
class SpendCategory {
  final String name;
  final IconData icon;
  final Color color; // icon color
  final Color tint; // light background behind the icon
  final double spent;
  final double budget;

  const SpendCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.tint,
    required this.spent,
    required this.budget,
  });

  double get remaining => budget - spent;
  double get progress => budget == 0 ? 0 : (spent / budget).clamp(0.0, 1.0);
}

/// Sample data. Keep this consistent with Home and Expense Details.
const sampleCategories = <SpendCategory>[
  SpendCategory(
    name: 'Groceries',
    icon: Icons.shopping_bag_outlined,
    color: Color(0xFF0369A1),
    tint: Color(0xFFE0F2FE),
    spent: 42.10,
    budget: 50,
  ),
  SpendCategory(
    name: 'Food & Drink',
    icon: Icons.local_cafe_outlined,
    color: Color(0xFFC2570C),
    tint: Color(0xFFFEF3C7),
    spent: 18.50,
    budget: 30,
  ),
  SpendCategory(
    name: 'Bills',
    icon: Icons.bolt_outlined,
    color: Color(0xFF16A34A),
    tint: Color(0xFFDCFCE7),
    spent: 60.00,
    budget: 70,
  ),
];
