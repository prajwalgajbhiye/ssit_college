import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../user_selection_screen.dart';
import '../../../auth_screen_v2/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all saved data
    // Alternatively, remove specific keys:
    // await prefs.remove('isLoggedIn');
    // await prefs.remove('userType');

    // Navigate back to UserSelectionScreen or LoginScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white, // Dark background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // Profile Picture
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/no_dp.jpeg'), // Replace with actual image asset or network image
                ),
              ),
              const SizedBox(height: 20),
              // Student Information
              Text(
                'John Doe', // Student Name
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'University of XYZ', // University Name
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Computer Science, Year 3', // Course & Year
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              // Details in card layout
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileRow(
                        icon: CupertinoIcons.mail,
                        title: 'Email',
                        value: 'john.doe@universityxyz.com',
                      ),
                      const SizedBox(height: 16),
                      _buildProfileRow(
                        icon: CupertinoIcons.phone,
                        title: 'Phone',
                        value: '+1 123-456-7890',
                      ),
                      const SizedBox(height: 16),
                      _buildProfileRow(
                        icon: CupertinoIcons.book,
                        title: 'Course',
                        value: 'Computer Science',
                      ),
                      const SizedBox(height: 16),
                      _buildProfileRow(
                        icon: CupertinoIcons.calendar,
                        title: 'Year',
                        value: '3rd Year',
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Logout Button
              ElevatedButton.icon(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade900, // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable function to build profile info rows
  Widget _buildProfileRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 28),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
