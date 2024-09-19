import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../components/custom_class.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';

void main() {
  runApp(OTPScreenApp());
}

class OTPScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: OTPScreen(),
    );
  }
}

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  String? _sentOtp; // To store the sent OTP

  // Function to send OTP to 02_admin email
  Future<void> sendOtpToAdmin() async {
    String username = 'gajbhiyeprajwal466@gmail.com';
    String password = 'fhhr avhb piln qzwb'; // Your app-specific password

    final smtpServer = gmail(username, password);

    // Generate a 4-digit OTP
    String otp = _generate4DigitOtp();
    setState(() {
      _sentOtp = otp; // Store the OTP
    });

    final message = Message()
      ..from = Address(username, 'OTP Service')
      ..recipients.add(username) // Send to the 02_admin email
      ..subject = 'Your Admin OTP Code'
      ..text = 'Your 4-digit OTP code is: $otp';

    try {
      await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to 02_admin email')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending OTP: $e')),
      );
    }
  }

  // Function to generate a 4-digit OTP
  String _generate4DigitOtp() {
    var random = Random();
    return (1000 + random.nextInt(9000)).toString(); // 4-digit OTP
  }

  // Function to verify OTP and navigate
  void _verifyOtp() {
    String enteredOtp = _controller1.text + _controller2.text + _controller3.text + _controller4.text;
    if (_sentOtp == enteredOtp) {
      // OTP matched, navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StudentBottomNavBar()), // Your home screen
      );
    } else {
      // OTP mismatch, show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please enter the 4-digit OTP sent to your phone.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpField(first: true, last: false, controller: _controller1),
                OtpField(first: false, last: false, controller: _controller2),
                OtpField(first: false, last: false, controller: _controller3),
                OtpField(first: false, last: true, controller: _controller4),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _verifyOtp, // Verify OTP on submit
              child: const Text('Submit OTP'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: sendOtpToAdmin, // Send OTP to admin email
              child: const Text(
                'Ask OTP from Admin',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Note: Please make sure the OTP is valid for the next 10 minutes.',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
