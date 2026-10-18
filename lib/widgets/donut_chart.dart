import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Donut chart drawn with CustomPainter (no extra packages).
/// Put any widget in [center] (e.g. the "Total Spent" label).
class DonutChart extends StatelessWidget {
  final List<double> values;
  final List<Color> colors;
  final double size;
  final double strokeWidth;
  final Widget? center;

  const DonutChart({
    super.key,
    required this.values,
    required this.colors,
    this.size = 170,
    this.strokeWidth = 22,
    this.center,
  }) : assert(values.length == colors.length);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _DonutPainter(
              values: values,
              colors: colors,
              strokeWidth: strokeWidth,
            ),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  final double strokeWidth;

  _DonutPainter({
    required this.values,
    required this.colors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final rect =
        Rect.fromCircle(center: size.center(Offset.zero), radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final total = values.fold(0.0, (a, b) => a + b);
    if (total == 0) {
      paint.color = const Color(0xFFE5E7EB);
      canvas.drawArc(rect, 0, 2 * math.pi, false, paint);
      return;
    }

    const gap = 0.04; // small gap between segments (radians)
    var start = -math.pi / 2;
    for (var i = 0; i < values.length; i++) {
      final sweep = values[i] / total * 2 * math.pi;
      paint.color = colors[i];
      canvas.drawArc(rect, start + gap / 2, sweep - gap, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) =>
      old.values != values ||
      old.colors != colors ||
      old.strokeWidth != strokeWidth;
}
