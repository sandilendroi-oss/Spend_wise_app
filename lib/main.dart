import 'package:flutter/material.dart';
import 'package:speed_wise_app/screens/program_listing_screen.dart';
import 'package:speed_wise_app/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ProgramListingScreen(),
    );
  }
}
