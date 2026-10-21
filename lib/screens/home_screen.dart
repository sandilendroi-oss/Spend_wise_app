import 'package:flutter/material.dart';
import 'package:speed_wise_app/theme/app_colors.dart';
import 'package:speed_wise_app/widgets/balance_card.dart';
import 'package:speed_wise_app/widgets/bottom_nav_bar.dart';
import 'package:speed_wise_app/widgets/expense_tile.dart';
import 'package:speed_wise_app/widgets/spending_bar_chart.dart';
import '../models/expense.dart';
import 'package:speed_wise_app/navigations/app_nav.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int>? onNavTap;
  final ValueChanged<Expense>? onExpenseTap;
  const HomeScreen({super.key , this.onNavTap, this.onExpenseTap});

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // Sample data for the UI (no backend yet).
  static const List<String> _weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  static const List<double> _weeklySpending = [42, 65, 30, 88, 54, 120, 76];

  static final List<Expense> _recentExpenses = [
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
    Expense(
      id: '3',
      merchant: 'Starbucks',
      category: 'Food & Drink',
      amount: 5.50,
      date: DateTime(2026, 10, 18, 9, 15),
      paymentMethod: 'Visa •••• 4417',
      icon: Icons.local_cafe_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthLabel = '${_monthNames[now.month - 1]} ${now.year}';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(monthLabel: monthLabel),
              const SizedBox(height: 24),
              const BalanceCard(amount: '4,250.00'),
              const SizedBox(height: 24),
              const _SectionTitle('Spending Weekly'),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: SpendingBarChart(
                    values: _weeklySpending,
                    labels: _weekdays,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const _SectionTitle('Recent Expenses'),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    for (var i = 0; i < _recentExpenses.length; i++) ...[
                      if (i > 0)
                        const Divider(height: 1, indent: 16, endIndent: 16),
                      ExpenseTile(
                        icon: _recentExpenses[i].icon,
                        categoryName: _recentExpenses[i].merchant,
                        subtitle: _recentExpenses[i].category,
                        amount: '-${_recentExpenses[i].amount.toStringAsFixed(2)}',
                        onTap: () => onExpenseTap?.call(_recentExpenses[i]),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavBar(
      currentIndex: AppNav.home, // 0
      onTap: (index) => AppNav.onTabTapped(context, index, AppNav.home),
),
    );
  }
}

class _Header extends StatelessWidget {
  final String monthLabel;

  const _Header({required this.monthLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monthLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Expenses',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
        const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.person,
            color: AppColors.cardWhiteColor,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
    );
  }
}

