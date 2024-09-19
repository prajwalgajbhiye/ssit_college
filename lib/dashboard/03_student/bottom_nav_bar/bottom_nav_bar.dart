import 'dart:io'; // Import for closing the app
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssit_college_app/dashboard/03_student/bottom_nav_bar/tab/data_tab/data_tab.dart';
import 'package:ssit_college_app/dashboard/03_student/bottom_nav_bar/tab/form_tab/form_tab.dart';
import 'package:ssit_college_app/dashboard/03_student/bottom_nav_bar/tab/profile_tab/profile_tab.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: StudentBottomNavBar(),
    );
  }
}

class StudentBottomNavBar extends StatefulWidget {
  @override
  _StudentBottomNavBarState createState() => _StudentBottomNavBarState();
}

class _StudentBottomNavBarState extends State<StudentBottomNavBar> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  final List<Widget> _screens = [
    const FormsScreen(),
    DataScreen(),
    ProfileScreen(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavBarTap(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  Future<bool> _onWillPop() async {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blurring background
        child: CupertinoAlertDialog(
          title: Container(
            color: Colors.transparent,
            child: const Text('Exit App'),
          ),
          content: Container(
            color: Colors.transparent,
            child: const Text('Wait! Are you sure you want to leave? You will miss all the fun assignments! 😜'),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false), // Close the dialog without exiting
              child: const Text('No, take me back!'),
            ),
            CupertinoDialogAction(
              onPressed: () => exit(0), // Exit the app
              child: const Text('Yes, I\'m done!'),
            ),
          ],
        ),
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Override back button behavior
      child: CupertinoPageScaffold(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _screens,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: 1,
                duration: Duration(milliseconds: 300),
                child: CupertinoTabBar(
                  currentIndex: _currentIndex,
                  onTap: _onNavBarTap,
                  activeColor: CupertinoColors.activeBlue,
                  items: [
                    BottomNavigationBarItem(
                      icon: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        transform: Matrix4.identity()
                          ..scale(_currentIndex == 0 ? 1.25 : 1.0),
                        child: Icon(CupertinoIcons.square_list),
                      ),
                      label: _currentIndex == 0 ? '' : 'Forms',
                    ),
                    BottomNavigationBarItem(
                      icon: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        transform: Matrix4.identity()
                          ..scale(_currentIndex == 1 ? 1.25 : 1.0),
                        child: Icon(CupertinoIcons.doc_plaintext),
                      ),
                      label: _currentIndex == 1 ? '' : 'Data',
                    ),
                    BottomNavigationBarItem(
                      icon: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        transform: Matrix4.identity()
                          ..scale(_currentIndex == 2 ? 1.25 : 1.0),
                        child: Icon(CupertinoIcons.person),
                      ),
                      label: _currentIndex == 2 ? '' : 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
