import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssit_college_app/dashboard/01_director/director_bottom_nav_bar/profile_page/profile_page.dart';
import 'package:ssit_college_app/dashboard/01_director/director_bottom_nav_bar/search_page/search_page.dart';
import 'package:ssit_college_app/dashboard/01_director/director_bottom_nav_bar/add_admin/add_admin.dart';
import 'package:ssit_college_app/dashboard/01_director/director_bottom_nav_bar/home_page/home_page.dart';
import 'package:ssit_college_app/dashboard/01_director/director_bottom_nav_bar/notification_page/notification_page.dart';
import 'dart:io'; // Required for exiting the app

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    const AddAdmin(),
    NotificationsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToAddAdmin(BuildContext context) {
    Navigator.of(context).push(_createAddAdminRoute());
  }

  Route _createAddAdminRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddAdmin(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: CupertinoAlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit the app?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); // Pop the dialog and return false
              },
            ),
            CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: () {
                exit(0); // Exit the app
              },
            ),
          ],
        ),
      ),
    ) ??
        false; // Return false if dialog is dismissed without selecting an option
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context), // Intercept back button press
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAddAdmin(context),
          backgroundColor: Colors.purple, // Customize to match your color
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0, // Padding for the FloatingActionButton
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: _selectedIndex == 0 ? Colors.purple : Colors.black,
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: _selectedIndex == 1 ? Colors.purple : Colors.black,
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                ),
                SizedBox(width: 40), // The space for the floating action button
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: _selectedIndex == 3 ? Colors.purple : Colors.black,
                  ),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.admin_panel_settings,
                    color: _selectedIndex == 4 ? Colors.purple : Colors.black,
                  ),
                  onPressed: () {
                    _onItemTapped(4);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
