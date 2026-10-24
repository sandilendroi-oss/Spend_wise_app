import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../screens/home_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/expense_details_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class AppNav {
  AppNav._();

  static const int home = 0, add = 1, settings = 2, stats = 3;

  /// Call from the Login button. Replaces the whole stack with Home,
  /// so the back button can never return to Login.
  static void goHomeAfterLogin(BuildContext context) =>
      _replaceStack(context, home);

  /// Handles a bottom-nav tap from any tab screen.
  static void onTabTapped(BuildContext context, int tab, int current) {
    if (tab == current) return;
    if (tab == add) {
      // Add is an action, not a tab: push a placeholder on top.
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const _AddPlaceholder()));
      return;
    }
    _replaceStack(context, tab);
  }

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static String _formatDate(DateTime d) {
    final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final m = d.minute.toString().padLeft(2, '0');
    final ampm = d.hour >= 12 ? 'PM' : 'AM';
    return '${_months[d.month - 1]} ${d.day}, ${d.year}, $h:$m $ampm';
  }

  /// Opens details on top of the current tab. Back returns to that tab.
  static void openDetails(BuildContext context, Expense expense) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExpenseDetailsScreen(
          expenseData: {
            'title': expense.merchant,
            'amount': expense.amount,
            'merchant': expense.merchant,
            'category': expense.category,
            'paymentMethod': expense.paymentMethod,
            'date': _formatDate(expense.date),
            'notes': expense.notes ?? '—',
          },
        ),
      ),
    );
  }

  // Makes the chosen tab the only route, with no slide animation,
  // so tabs behave like tabs and the stack never grows.
  static void _replaceStack(BuildContext context, int tab) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (ctx, _, _) => _screenFor(ctx, tab),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      (route) => false,
    );
  }

  static Widget _screenFor(BuildContext ctx, int tab) {
    switch (tab) {
      case home:
        return HomeScreen(
          onNavTap: (i) => onTabTapped(ctx, i, home),
          onExpenseTap: (e) => openDetails(ctx, e),
        );
      case stats:
        return StatsScreen(onNavTap: (i) => onTabTapped(ctx, i, stats));
      default:
        return _SettingsPlaceholder(
          onNavTap: (i) => onTabTapped(ctx, i, settings),
        );
    }
  }
}

class _SettingsPlaceholder extends StatelessWidget {
  final ValueChanged<int> onNavTap;
  const _SettingsPlaceholder({required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings - coming soon')),
      bottomNavigationBar: BottomNavBar(
        currentIndex: AppNav.settings, // 2
        onTap: (index) => AppNav.onTabTapped(context, index, AppNav.settings),
      ),
    );
  }
}

class _AddPlaceholder extends StatelessWidget {
  const _AddPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: const Center(child: Text('Add Expense - coming soon')),
    );
  }
}
