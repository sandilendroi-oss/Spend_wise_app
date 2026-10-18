import 'package:flutter/material.dart';
import '../models/expense.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int>? onNavTap;
  final ValueChanged<Expense>? onExpenseTap;
  const HomeScreen({super.key, this.onNavTap, this.onExpenseTap});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Home - placeholder')));
}
