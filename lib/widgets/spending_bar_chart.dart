import 'package:flutter/material.dart';
import 'package:speed_wise_app/theme/app_colors.dart';

/// A simple, dependency-free bar chart (one bar per label).
///
/// The tallest bar is highlighted in dark green; the others use light green.
/// Built with plain Flutter widgets so no chart package is needed.
class SpendingBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final double height;

  const SpendingBarChart({
    super.key,
    required this.values,
    required this.labels,
    this.height = 160,
  });

  // Space reserved under each bar for the gap + the weekday label.
  static const double _labelBlockHeight = 28;

  @override
  Widget build(BuildContext context) {
    assert(
      values.length == labels.length,
      'SpendingBarChart needs one label per value',
    );

    if (values.isEmpty) {
      return SizedBox(height: height);
    }

    var maxValue = 0.0;
    for (final value in values) {
      if (value > maxValue) maxValue = value;
    }
    if (maxValue <= 0) maxValue = 1;

    final maxBarHeight = height - _labelBlockHeight;

    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < values.length; i++)
            Expanded(
              child: _Bar(
                label: labels[i],
                barHeight: (values[i] / maxValue * maxBarHeight)
                    .clamp(4.0, maxBarHeight)
                    .toDouble(),
                highlighted: values[i] == maxValue,
              ),
            ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String label;
  final double barHeight;
  final bool highlighted;

  const _Bar({
    required this.label,
    required this.barHeight,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: barHeight,
          decoration: BoxDecoration(
            color: highlighted
                ? AppColors.primaryColor
                : AppColors.primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}