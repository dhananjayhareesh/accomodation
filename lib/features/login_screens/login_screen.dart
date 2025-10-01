import 'dart:ui'; // For ImageFilter and opacity effect
import 'package:accomodation_admin/features/counterUser/dashbord/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../superAdmin/home_screens/view/home_screen_su_ad.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Colors
  final Color _primaryColor = const Color(0xFF372f24);
  final Color _secondaryColor = const Color(0xFFcfa338);
  final Color _backgroundColor = const Color(0xFFd3e4ec);
  final Color _inputBackgroundColor = Colors.white.withOpacity(0.3);

  // Demo Credentials
  final String demoUsername = "superadmin";
  final String demoPassword = "admin123";

  // Validation Method
  String? _validateField(String? value, String fieldName, int minLength) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

// Login Method with Demo Check
  void _login() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      // Super Admin login
      if (username == demoUsername && password == demoPassword) {
        Get.snackbar("Success", "Logged in successfully",
            snackPosition: SnackPosition.BOTTOM);
        Get.to(() => const HomeScreen()); // Navigate to Super Admin Home
      }
      // Counter User login
      else if (username == "counteruser" && password == "counter123") {
        Get.snackbar("Success", "Logged in successfully",
            snackPosition: SnackPosition.BOTTOM);
        Get.to(() => MainScreen()); // Navigate to Counter User Main
      }
      // Invalid login
      else {
        Get.snackbar("Error", "Invalid username or password",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  // Input Field Widget
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String fieldName,
    required int minLength,
    bool obscureText = false,
  }) {
    return SizedBox(
      width: 500,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: _primaryColor),
          filled: true,
          fillColor: _inputBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: _primaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(color: _primaryColor.withOpacity(0.5), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: _secondaryColor, width: 2),
          ),
          prefixIcon: Icon(icon, color: _primaryColor),
        ),
        validator: (value) => _validateField(value, fieldName, minLength),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background logo with low opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/png/logo.png', // Replace with your logo image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphism container with elegant padding
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: _secondaryColor, // Background color for container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 30),
                              // Header Text
                              const Text(
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF372f24),
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Username Field
                              _buildInputField(
                                label: 'Username',
                                controller: _usernameController,
                                icon: Icons.person,
                                fieldName: 'username',
                                minLength: 1,
                              ),

                              const SizedBox(height: 20),

                              // Password Field
                              _buildInputField(
                                label: 'Password',
                                controller: _passwordController,
                                icon: Icons.lock,
                                fieldName: 'password',
                                minLength: 6,
                                obscureText: true,
                              ),

                              const SizedBox(height: 30),

                              // Login Button with hover effect for web
                              SizedBox(
                                width: 500,
                                child: ElevatedButton(
                                  onPressed: _login,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: _primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: const Text('Login'),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Forgot Password Link
                              TextButton(
                                onPressed: () {
                                  Get.snackbar(
                                      "Info", "Forgot Password clicked",
                                      snackPosition: SnackPosition.BOTTOM);
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Color(0xFFa77484)),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
