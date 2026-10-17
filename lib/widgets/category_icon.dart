import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const CategoryIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xFFE5F4E8),
    this.iconColor = const Color(0xFF25834A),
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size * 0.5,
      ),
      );
  }
}
