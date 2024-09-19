import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../components/colors.dart';
import 'auth_service.dart';

class StudentSignUp extends StatefulWidget {
  const StudentSignUp({super.key});

  @override
  _StudentSignUpState createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoadingOtp = false;
  bool _isLoadingSignUp = false;
  bool _obscurePassword = true; // To toggle password visibility
  bool _obscureRePassword = true; // To toggle re-password visibility

  // Method to send OTP
  void _sendOtp() async {
    setState(() {
      _isLoadingOtp = true; // Show loading indicator
    });
    String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      bool result = await _authService.sendOtp(email);
      setState(() {
        _isLoadingOtp = false; // Stop loading indicator after OTP is sent
      });
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP sent to $email')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP')),
        );
      }
    } else {
      setState(() {
        _isLoadingOtp = false; // Stop loading even on failure
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email')),
      );
    }
  }

  // Method to verify OTP
  void _verifyOtp() {
    String otp = _otpController.text.trim();
    if (otp.isNotEmpty && _authService.verifyOtp(otp)) {
      setState(() {
// Should be true since it's verified
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP verified successfully'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid OTP'),
      ));
    }
  }

  // Method to sign up user
  void _signUp() async {
    setState(() {
      _isLoadingSignUp = true; // Show loading indicator
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String username = _usernameController.text.trim();
    String otp = _otpController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty && otp.isNotEmpty) {
      // Sign up the user
      UserCredential? userCredential = await _authService.studentSignUpWithEmailAndOtp(context, email, password, otp);

      // Save user data in Firestore only if the sign-up was successful
      if (userCredential != null) {
        await FirebaseFirestore.instance.collection('student').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,  // Store uid

          'email': email,
          'username': username,
          'timestamp': FieldValue.serverTimestamp(), // Save timestamp
        });
      }

      setState(() {
        _isLoadingSignUp = false; // Stop loading after sign-up
      });
    } else {
      setState(() {
        _isLoadingSignUp = false; // Stop loading even on failure
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.height * 1,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create Your Account",
                      style: TextStyle(
                        color: loginButtonColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sign up to get started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: labelColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: labelColor),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: _isLoadingOtp
                            ? CircularProgressIndicator()
                            : IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _sendOtp,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _otpController,
                      decoration: InputDecoration(
                        labelText: 'OTP',
                        labelStyle: TextStyle(color: labelColor),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.verified),
                          onPressed: _verifyOtp,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: labelColor),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _rePasswordController,
                      obscureText: _obscureRePassword,
                      decoration: InputDecoration(
                        labelText: 'Re-enter Password',
                        labelStyle: TextStyle(color: labelColor),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureRePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureRePassword = !_obscureRePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoadingSignUp ? null : _signUp, // Disable button during sign-up
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: loginButtonColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoadingSignUp
                          ? CircularProgressIndicator()
                          : const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: textFieldColor,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
