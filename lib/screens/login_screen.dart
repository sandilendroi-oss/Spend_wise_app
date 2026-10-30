import 'package:flutter/material.dart';
import 'package:speed_wise_app/screens/program_listing_screen.dart';
import 'package:speed_wise_app/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    // 1. Validate form fields
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate a network/mock API delay (e.g., checking credentials)
      await Future.delayed(const Duration(seconds: 1));

      setState(() => _isLoading = false);

      if (!mounted) return;

      // 2. If valid, navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProgramListingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Excelerate',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cardWhiteColor,
                ),
              ),
              Card(
                color: AppColors.cardWhiteColor,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey, // Attach the form key
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
                        const SizedBox(height: 4),
                        const Text(
                          'Please enter your credentials to continue',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: AppColors.textColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!val.contains('@') || !val.contains('.')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: AppColors.textColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (val.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        
                        // Login Button inside Form
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.cardWhiteColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}