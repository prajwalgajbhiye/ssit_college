import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ssit_college_app/dashboard/03_student/auth_screen_v2/student_sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/test_component.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';
import 'auth_service.dart'; // Import AuthService
import '../../../components/colors.dart';
import 'forgot_password_screen.dart';
import 'otp_screen.dart';

class StudentSignIn extends StatefulWidget {
  const StudentSignIn({super.key});

  @override
  _StudentSignInState createState() => _StudentSignInState();
}

class _StudentSignInState extends State<StudentSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = '';
  bool _isLoading = false;

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoading = true; // Show loader
      });

      User? user = await _authService.loginWithEmail(email, password);
      if (user != null) {
        // Save login state and user type in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userType', '03_student'); // Save the user type

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentBottomNavBar()),
        );
      } else {
        setState(() {
          _errorMessage = 'Login failed. Please check your credentials.';
          _isLoading = false; // Hide loader after process
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Please fill out all fields.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                backgroundColor2,
                backgroundColor2,
                backgroundColor4,
              ],
            ),
          ),
          child: Stack(
            children: [
              // Hide these Positioned widgets when the keyboard is visible
              if (!isKeyboardVisible)
                Positioned(
                  top: 60,
                  left: 20,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              if (!isKeyboardVisible)
                const Positioned(
                  top: 105,
                  left: 35,
                  child: Text(
                    "BACK",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Welcome Back, Student!",
                        style: TextStyle(
                          color: loginButtonColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Login to manage your forms",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: labelColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),

                      const SizedBox(height: 8),
                      Text(
                        "Pro tip: Always save your work... unless you like surprises!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: labelColor,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 40),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: labelColor),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: labelColor),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: loginButtonColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 120),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 40),
                      // Other UI elements remain unchanged
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * 0.2,
                            color: Colors.black12,
                          ),
                          Text(
                            "  Or continue with   ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor2,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * 0.2,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const ForgotPassword()));
                            },
                            child: Text(
                              "Forgot your password?",
                              style: TextStyle(
                                color: textFieldColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const StudentSignUp()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Don't worry, we won't give you homework!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: labelColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                    ],
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
