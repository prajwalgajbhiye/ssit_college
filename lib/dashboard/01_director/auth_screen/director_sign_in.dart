import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../director_bottom_nav_bar/bottom_nav_bar.dart';

class CollegeDirectorLoginPage extends StatefulWidget {
  const CollegeDirectorLoginPage({Key? key}) : super(key: key);

  @override
  _CollegeDirectorLoginPageState createState() =>
      _CollegeDirectorLoginPageState();
}

class _CollegeDirectorLoginPageState extends State<CollegeDirectorLoginPage>
    with TickerProviderStateMixin { // Ensure we're using TickerProviderStateMixin
  late AnimationController _animationController;
  late Animation<Offset> _usernameAnimation;
  late Animation<Offset> _passwordAnimation;

  late AnimationController _shiverController;
  late Animation<Offset> _shiverAnimation;
  late AssetImage _backgroundImage;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize the text field animation controller but don't start it yet
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _usernameAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
        );
    _passwordAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
        );

    // Initialize the background image and listen for its loading
    _backgroundImage = const AssetImage(
        'images/ssit_collage_image_for_director_login_page.JPG');

    // Initialize _shiverController here
    _shiverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Initialize _shiverAnimation with default value
    _shiverAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_shiverController);

    _backgroundImage.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo image, bool synchronousCall) {
        // Image is loaded
        // Start the shivering animation
        _startShiveringAnimation();
      }),
    );
  }

  void _startShiveringAnimation() {
    // Since _shiverController is already initialized, we only need to define _shiverAnimation
    _shiverAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween(begin: Offset.zero, end: const Offset(5, 0)), weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(5, 0), end: const Offset(-5, 0)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(-5, 0), end: const Offset(5, 0)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(5, 0), end: const Offset(-5, 0)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: const Offset(-5, 0), end: Offset.zero),
          weight: 1),
    ]).animate(_shiverController);

    _shiverController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Shivering animation is complete, start text field animations
        _animationController.forward();
      }
    });

    _shiverController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shiverController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Query Firestore for a document where the username matches
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('directors')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isNotEmpty) {
      // Retrieve the data from the first document found
      Map<String, dynamic> data =
      documents.first.data() as Map<String, dynamic>;
      String savedPassword = data['password'];

      if (password == savedPassword) {
        // If password matches, save login status and user type
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userType', '01_director'); // Save the user type

        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      } else {
        _showErrorMessage('Invalid username or password');
      }
    } else {
      _showErrorMessage('User not found');
    }
  }

  void _showErrorMessage(String message) {
    setState(() {
      _isLoading = false;
    });
    showCupertinoDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: CupertinoAlertDialog(
          title: const Text('Login Failed'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _shiverController,
            builder: (context, child) {
              return Transform.translate(
                offset: _shiverAnimation.value,
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Semi-transparent overlay with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.3),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'College Director Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SlideTransition(
                    position: _usernameAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CupertinoTextField(
                        controller: _usernameController,
                        prefix: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Icon(CupertinoIcons.person,
                              color: Colors.white),
                        ),
                        placeholder: 'Username',
                        placeholderStyle: const TextStyle(
                          color: Colors.white70,
                        ),
                        style: const TextStyle(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _passwordAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CupertinoTextField(
                        controller: _passwordController,
                        obscureText: true,
                        prefix: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Icon(CupertinoIcons.lock,
                                color: Colors.white)),
                        placeholder: 'Password',
                        placeholderStyle: const TextStyle(
                          color: Colors.white70,
                        ),
                        style: const TextStyle(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  _isLoading
                      ? const CupertinoActivityIndicator(radius: 15)
                      : CupertinoButton(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(20),
                    onPressed: _login,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Powered by SSIT College',
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
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
