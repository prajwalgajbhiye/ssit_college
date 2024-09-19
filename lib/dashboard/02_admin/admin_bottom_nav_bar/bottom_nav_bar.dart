import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:ssit_college_app/dashboard/02_admin/admin_bottom_nav_bar/tab/requests_tab.dart';
import 'package:ssit_college_app/dashboard/02_admin/admin_bottom_nav_bar/tab/students_tab.dart';
import '../../../components/colors.dart';
import '../../03_student/bottom_nav_bar/tab/profile_tab/profile_tab.dart';

void main() {
  runApp(const AdminBottomNavBarApp());
}

class AdminBottomNavBarApp extends StatelessWidget {
  const AdminBottomNavBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const RequestsScreen(),
    const StudentsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await _showExitConfirmationDialog(context);
        return shouldExit;
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: backgroundColor,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildNavBarItem(Icons.assignment, 'Requests', Colors.green),
            _buildNavBarItem(Icons.school, 'Students', Colors.orange),
            _buildNavBarItem(Icons.person, 'Profile', Colors.purple),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(IconData icon, String label, Color color) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.2),
        ),
        child: Icon(icon, color: color),
      ),
      label: label,
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            title: Text("Wait!"),
            content: Text("Are you sure you want to exit? We will miss you! 😢"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Stay in the app
                },
                child: Text("No, take me back!"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Exit the app
                },
                child: Text("Yes, I'm sure!"),
              ),
            ],
          ),
        );
      },
    ) ?? false;
  }
}
