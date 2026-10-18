import 'package:flutter/material.dart';
import '../models/spend_category.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart'; // check this file name in lib/widgets
import '../widgets/budget_card.dart';
import '../widgets/donut_chart.dart';

const _muted = Color(0xFF6B7280);

class StatsScreen extends StatefulWidget {
  /// Called when a bottom-nav item is tapped (index = position in BottomNavBar).
  /// The navigation owner connects this in Phase 7.
  final ValueChanged<int>? onNavTap;

  const StatsScreen({super.key, this.onNavTap});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // Position of "Stats" in the team's BottomNavBar:
  // Home 0, Add Expense 1, Settings 2, Stats 3.
  static const _statsTabIndex = 3;

  static const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  final DateTime _today = DateTime.now();
  late final DateTime _weekStart =
      DateTime(_today.year, _today.month, _today.day)
          .subtract(Duration(days: _today.weekday - 1));
  late int _selectedIndex = _today.weekday - 1;

  // TODO: load the categories for the selected day instead of sample data.
  final List<SpendCategory> _categories = sampleCategories;
  final double _dailyBudget = 150;

  DateTime get _selectedDate => _weekStart.add(Duration(days: _selectedIndex));
  double get _totalSpent => _categories.fold(0.0, (sum, c) => sum + c.spent);

  String _shortDate(DateTime d) => '${_months[d.month - 1]} ${d.day}';
  double _percent(SpendCategory c) =>
      _totalSpent == 0 ? 0 : c.spent / _totalSpent * 100;

  @override
  Widget build(BuildContext context) {
    final sorted = [..._categories]..sort((a, b) => b.spent.compareTo(a.spent));

    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildWeekStrip(),
            const SizedBox(height: 16),
            _buildDonutCard(sorted),
            const SizedBox(height: 20),
            const Text(
              'Budget Breakdown · Daily',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 10),
            for (final c in _categories) ...[
              BudgetCard(
                icon: c.icon,
                backgroundColor: c.tint,
                iconColor: c.color,
                categoryName: c.name,
                percentageSubtitle: '${_percent(c).toStringAsFixed(1)}% of today',
                spentAmount: c.spent.toStringAsFixed(2),
                limitAmount: c.budget.toStringAsFixed(0),
                remainingAmount: c.remaining >= 0
                    ? '${formatMoney(c.remaining)} remaining'
                    : '${formatMoney(-c.remaining)} over budget',
                progressValue: c.progress,
              ),
              const SizedBox(height: 10),
              // TODO (Phase 7): agree what tapping a category does.
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _statsTabIndex,
        onTap: (i) => widget.onNavTap?.call(i),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_weekdays[_today.weekday - 1]} ${_shortDate(_today)}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              const Text(
                'Stats',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.cardWhiteColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline,
              size: 20,
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekStrip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final date = _weekStart.add(Duration(days: i));
        final selected = i == _selectedIndex;
        return GestureDetector(
          onTap: () => setState(() => _selectedIndex = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: selected ? AppColors.darkGreenColor : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  _weekdays[i],
                  style: TextStyle(
                    fontSize: 9,
                    color: selected ? Colors.white70 : _muted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : _muted,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDonutCard(List<SpendCategory> sorted) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily Spending',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              Text(
                _shortDate(_selectedDate),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DonutChart(
            values: sorted.map((c) => c.spent).toList(),
            colors: sorted.map((c) => c.color).toList(),
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total Spent',
                  style: TextStyle(fontSize: 9, color: _muted),
                ),
                Text(
                  formatMoney(_totalSpent),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  'of \$${_dailyBudget.toStringAsFixed(0)} budget',
                  style: const TextStyle(fontSize: 9, color: _muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 14,
            runSpacing: 6,
            children: [
              for (final c in sorted)
                _LegendItem(
                  color: c.color,
                  label:
                      '${c.name.split(' ').first} ${_percent(c).toStringAsFixed(1)}%',
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
