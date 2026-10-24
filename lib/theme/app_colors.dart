import 'package:flutter/material.dart';

class AppColors {
  // Excelerate brand (sampled from logo)
  static const Color orangeColor = Color(0xFFEA7553);
  static const Color coralColor = Color(0xFFEB684B);
  static const Color pinkColor = Color(0xFFD9508A);
  static const Color magentaColor = Color(0xFFCC43B3);

  static const Color primaryColor = coralColor;
  static const Color secondaryColor = magentaColor;
  static const Color backgroundColor = Color(0xFFFFF7F4); // soft warm white
  static const Color cardWhiteColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF2B2B33); // dark neutral

  // Logo-style gradient, reusable on buttons / headers
  static const LinearGradient brandGradient = LinearGradient(
    colors: [orangeColor, coralColor, pinkColor, magentaColor],
  );
}
