import 'package:flutter/material.dart';
import 'package:speed_wise_app/screens/expense_details_screen.dart';
import 'package:speed_wise_app/screens/home_screen.dart';
import 'package:speed_wise_app/screens/stats_screen.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SpendWiseApp());
}

class SpendWiseApp extends StatelessWidget {
  const SpendWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpendWise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const StatsScreen(), // Change this to your desired initial screen
    );
  }
}
