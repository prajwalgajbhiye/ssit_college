import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../user_selection_screen.dart';
import '../../auth_screen/director_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
        appBar: AppBar(
          title: const Text('SSIT Director'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _logout,
            ),
          ],
          backgroundColor: Colors.black,
        ),
      body: const Center(
        child: Text(
          'Profile Page',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
