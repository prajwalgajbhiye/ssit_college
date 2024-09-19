import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../admin_bottom_nav_bar/bottom_nav_bar.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Flag to show loading indicator
  bool _obscurePassword = true; // To toggle password visibility

  late AnimationController _animationController;
  late Animation<Offset> _emailFieldAnimation;
  late Animation<Offset> _passwordFieldAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Define the animations for the text fields
    _emailFieldAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start off-screen at the bottom
      end: Offset.zero, // End at its natural position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _passwordFieldAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start off-screen at the bottom
      end: Offset.zero, // End at its natural position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));

    // Start the animation after a slight delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extend body behind the status bar
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/ssit_clg_img.JPG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                // Adjusted to fit all elements properly
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon and welcome text at the top
                  Column(
                    children: [
                      const SizedBox(height: 80),
                      // Icon
                      Icon(
                        Icons.supervised_user_circle,
                        color: Colors.white.withOpacity(0.9),
                        size: 80,
                      ),
                      const SizedBox(height: 10),
                      // Welcome text
                      Text(
                        'Admin Login',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Animated email field
                  SlideTransition(
                    position: _emailFieldAnimation,
                    child: TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Animated password field
                  SlideTransition(
                    position: _passwordFieldAnimation,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[700],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Show loading indicator when logging in
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await Future.delayed(
                          const Duration(milliseconds: 500));
                      await _login(context);
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Login',
                        style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Back button without app bar
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
          // "Powered by SSIT College" text at the bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Powered by SSIT College',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    String username = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorMessage(context, 'Please enter both username and password');
      return;
    }

    try {
      // Fetch 'containers' document from the 'admin' collection
      final DocumentSnapshot<Map<String, dynamic>> result =
      await FirebaseFirestore.instance
          .collection('admin')
          .doc('containers')
          .get();

      if (result.exists) {
        List<dynamic> containers = result.data()?['containers'] ?? [];

        // Find the matching username and password
        bool isValidUser = false;
        for (var container in containers) {
          if (container['username'] == username &&
              container['password'] == password) {
            isValidUser = true;
            break;
          }
        }

        if (isValidUser) {
          // If login successful, save login state and navigate to the dashboard
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userType', '02_admin'); // Save user type

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminBottomNavBarApp()),
          );
        } else {
          _showErrorMessage(context, 'Invalid username or password');
        }
      } else {
        _showErrorMessage(context, 'No users found');
      }
    } catch (e) {
      _showErrorMessage(context, 'Error logging in: $e');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: CupertinoAlertDialog(
          title: const Text('Login Failed'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
