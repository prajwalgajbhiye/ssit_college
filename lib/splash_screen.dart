import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'dashboard/01_director/director_bottom_nav_bar/bottom_nav_bar.dart';
import 'dashboard/02_admin/admin_bottom_nav_bar/bottom_nav_bar.dart';
import 'dashboard/03_student/bottom_nav_bar/bottom_nav_bar.dart';
import 'dashboard/user_selection_screen.dart';
import 'components/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _secondaryLogoAnimation;

  @override
  void initState() {
    super.initState();

    // Preload images to ensure they load quickly when the app starts
    _preloadImages();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Define animations for different elements
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack)),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.7, curve: Curves.easeInOut)),
    );

    _secondaryLogoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOutBack)),
    );

    // Start the animation
    _controller.forward();

    // Navigate after splash screen duration
    Future.delayed(const Duration(seconds: 6), () {
      _navigateAfterSplash();
    });
  }

  void _preloadImages() async {
    await precacheImage(const AssetImage('images/ssit_clg_img.JPG'), context);
    await precacheImage(
        const AssetImage('images/transparent_ssit_logo.png'), context);
    await precacheImage(
        const AssetImage('images/transparent_ncca_logo.png'), context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateAfterSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? userType = prefs.getString('userType');

    if (isLoggedIn && userType != null) {
      if (userType == '03_student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentBottomNavBar()),
        );
      } else if (userType == '02_admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminBottomNavBarApp()),
        );
      } else if (userType == '01_director') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserSelectionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor4,
      body: Stack(
        children: [
          // Background image with fade-in effect
          Positioned.fill(
            child: Image.asset(
              'images/ssit_clg_img.JPG',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          // Semi-transparent overlay to enhance text readability
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: SingleChildScrollView(
              // To handle smaller screens
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First Logo Animation
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: Container(
                      height: size.height * 0.25,
                      width: size.width * 0.5,
                      decoration: const BoxDecoration(
                        // Removed borderRadius to eliminate black circle
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.3),
                        //     blurRadius: 10,
                        //     offset: const Offset(0, 5),
                        //   ),
                        // ],
                        image: DecorationImage(
                          image: AssetImage("images/transparent_ssit_logo.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // College Name with Shimmer Effect
                  FadeTransition(
                    opacity: _textAnimation,
                    child: Shimmer.fromColors(
                      baseColor: Colors.orange.shade800,
                      highlightColor: Colors.yellow.shade600,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "SWAMINARAYAN SIDDHANTA INSTITUTE OF TECHNOLOGY, NAGPUR",
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade800,
                            shadows: const [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black45,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Secondary Logo Animation
                  ScaleTransition(
                    scale: _secondaryLogoAnimation,
                    child: Container(
                      height: size.height * 0.2,
                      width: size.width * 0.4,
                      decoration: const BoxDecoration(
                        // Removed borderRadius to eliminate black circle
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.3),
                        //     blurRadius: 10,
                        //     offset: const Offset(0, 5),
                        //   ),
                        // ],
                        image: DecorationImage(
                          image:
                          AssetImage("images/transparent_ncca_logo.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
