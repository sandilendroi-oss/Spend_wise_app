import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String merchant;
  final String category;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String? notes;
  final IconData icon;

  const Expense({
    required this.id,
    required this.merchant,
    required this.category,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    required this.icon,
    this.notes,
  });
}

final sampleExpenses = <Expense>[
  Expense(
    id: '1',
    merchant: 'Woolworths',
    category: 'Groceries',
    amount: 452.90,
    date: DateTime(2026, 10, 16, 14, 30),
    paymentMethod: 'Visa •••• 4417',
    notes: 'Weekly groceries',
    icon: Icons.shopping_basket_outlined,
  ),
  Expense(
    id: '2',
    merchant: "Nando's",
    category: 'Food & Drink',
    amount: 189.00,
    date: DateTime(2026, 10, 17, 19, 10),
    paymentMethod: 'Cash',
    icon: Icons.restaurant_outlined,
  ),
];