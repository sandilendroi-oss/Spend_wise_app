import 'package:flutter/material.dart';
import 'package:speed_wise_app/theme/app_colors.dart';
import 'package:speed_wise_app/theme/app_theme.dart';
import 'package:speed_wise_app/navigations/app_nav.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to SpendWise',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.cardWhiteColor,
              ),
            ),
            Card(
              color: AppColors.cardWhiteColor,
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      'Please enter your credentials to continue',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle:
                                const TextStyle(color: AppColors.textColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle:
                                const TextStyle(color: AppColors.textColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the home screen
                AppNav.goHomeAfterLogin(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cardWhiteColor,
                foregroundColor: AppColors.backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        )
      ),
    );
  }
}