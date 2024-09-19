import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/test_component.dart';
import '../../02_admin/admin_bottom_nav_bar/bottom_nav_bar.dart';
import 'otp_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Variable to store the generated OTP
  String? _sentOtp;

  // Function for 03_student sign-up with email and OTP verification
  Future<UserCredential?> studentSignUpWithEmailAndOtp(
      BuildContext context, String email, String password, String enteredOtp) async {
    if (verifyOtp(enteredOtp)) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          // Store 03_student data in Firestore
          await _firestore.collection('03_student').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,  // Store uid

            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          });

          // Navigate to OTPScreenApp if sign-up is successful
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OTPScreenApp()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Student Sign-up successful!')),
          );
          return userCredential; // Return the UserCredential here
        }
      } catch (e) {
        print('Sign-up Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up failed')),
        );
        return null; // Return null in case of failure
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP does not match')),
      );
      return null; // Return null if OTP verification fails
    }
    return null; // Default return in case something else goes wrong
  }


  Future<void> _setUserType(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('userType', userType); // '03_student' or '02_admin'
  }

  // Example login method that checks if the user is an 02_admin or 03_student and saves the user type

  // Function for 02_admin sign-up with email and OTP verification
  Future<UserCredential?> adminSignUpWithEmailAndOtp(
      BuildContext context, String email, String password, String enteredOtp) async {
    if (verifyOtp(enteredOtp)) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          // Store 02_admin data in Firestore
          await _firestore.collection('02_admin').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,  // Store uid

            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          });

          // Navigate to AnimatedBottomNavBar if sign-up is successful
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminBottomNavBarApp()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Admin Sign-up successful!')),
          );
          return userCredential; // Return the UserCredential here
        }
      } catch (e) {
        print('Sign-up Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up failed')),
        );
        return null; // Return null in case of failure
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP does not match')),
      );
      return null; // Return null if OTP verification fails
    }
    return null; // Default return in case something else goes wrong
  }

  // Send OTP via email using the mailer package
  Future<bool> sendOtp(String email, {bool askAdminOtp = false}) async {
    try {
      // Gmail SMTP server configuration
      String username = 'gajbhiyeprajwal466@gmail.com';
      String password = 'fhhr avhb piln qzwb'; // Your app password here

      final smtpServer = gmail(username, password);

      // Generate a random OTP: 4-digit for forgot password, 6-digit for others
      String otp = askAdminOtp ? _generate4DigitOtp() : _generateOtp();

      // Store the generated OTP
      _sentOtp = otp;

      // Compose the email with a different message for forgot password
      final message = Message()
        ..from = Address(username, 'Prajwal OTP Service')
        ..recipients.add(email) // Recipient email
        ..subject = 'Your OTP Code'
        ..text = askAdminOtp
            ? 'Your password OTP is: $otp' // Forgot password message
            : 'Your OTP code is: $otp'; // Default sign-up OTP message

      // Send the email
      final sendReport = await send(message, smtpServer);

      if (sendReport != null) {
        print('OTP sent: $otp');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  // Generate a 4-digit OTP for forgot password
  String _generate4DigitOtp() {
    var random = Random();
    return (1000 + random.nextInt(9000)).toString(); // 4-digit OTP
  }

  // Generate a 6-digit OTP
  String _generateOtp() {
    var random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Verify if the entered OTP matches the sent one
  bool verifyOtp(String enteredOtp) {
    if (_sentOtp == enteredOtp) {
      print('OTP verification successful');
      return true;
    } else {
      print('OTP verification failed');
      return false;
    }
  }

  // Login with email and password, differentiating between 03_student and 02_admin
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        bool isAdmin = await isAdminEmail(email);
        bool isStudent = await _isStudentEmail(email);

        if (isAdmin) {
          await _setUserType('02_admin');

          // If 02_admin, navigate to 02_admin dashboard
          return user;
        } else if (isStudent) {
          // If 03_student, navigate to 03_student dashboard
          return user;
        } else {
          await _setUserType('03_student');

          throw ('User email is not assigned to 03_student or 02_admin.');
        }
      }
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
    return null;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in: $e');
      return null;
    }
  }
  // Check if the email is registered as a 03_student in Firestore
  Future<bool> _isStudentEmail(String email) async {
    try {
      QuerySnapshot result = await _firestore.collection('03_student')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return result.docs.isNotEmpty;
    } catch (e) {
      print('Error checking 03_student email: $e');
      return false;
    }
  }

  // Check if the email is registered as an 02_admin in Firestore
  Future<bool> isAdminEmail(String email) async {
    try {
      QuerySnapshot result = await _firestore.collection('02_admin')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return result.docs.isNotEmpty;
    } catch (e) {
      print('Error checking 02_admin email: $e');
      return false;
    }
  }

  // Sign in with Google

  // Check if user exists in Firestore, and create if not
  Future<void> _checkAndCreateUserInFirestore(User user) async {
    DocumentSnapshot doc = await _firestore.collection('03_student').doc(user.uid).get();
    if (!doc.exists) {
      await _firestore.collection('03_student').doc(user.uid).set({
        'email': user.email,
        'username': user.displayName ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Sign out Error: $e');
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}
