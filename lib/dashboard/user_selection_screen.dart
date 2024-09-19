import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ssit_college_app/components/colors.dart';
import '01_director/auth_screen/director_sign_in.dart';
import '02_admin/auth_screen/admin_sign_in.dart';
import '03_student/auth_screen_v2/student_sign_in.dart';
import '4_provisional_addmision/provisinal_admission.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserSelectionScreen(),
    );
  }
}

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  _UserSelectionScreenState createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // Animations for the role options
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;
  late Animation<Offset> _animation3;
  late Animation<Offset> _animation4;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    // Scale animation for the "Welcome" text
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Define animations with staggered intervals
    _animation1 = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-1.5, 0.0),
          end: const Offset(0.1, 0.0),
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.1, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.4,
        ),
      ),
    );

    _animation2 = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-1.5, 0.0),
          end: const Offset(0.1, 0.0),
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.1, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.2,
          0.6,
        ),
      ),
    );

    _animation3 = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-1.5, 0.0),
          end: const Offset(0.1, 0.0),
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.1, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.4,
          0.8,
        ),
      ),
    );

    _animation4 = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-1.5, 0.0),
          end: const Offset(0.1, 0.0),
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.1, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.6,
          1.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor1, backgroundColor4],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Welcome to Swaminarayan Siddhanta Institute of Technology! Please select your role to continue.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _scaleAnimation,
                child: const Text(
                  "Welcome",
                  style: TextStyle(
                      letterSpacing: 5,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: "BoldText"),
                ),
              ),
              const SizedBox(height: 20),
              // First role option with animation
              SlideTransition(
                position: _animation1,
                child: roleOption(
                  context,
                  icon: Icons.admin_panel_settings,
                  title: 'Director',
                  color: Colors.blueAccent,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const CollegeDirectorLoginPage()));
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Second role option with animation
              SlideTransition(
                position: _animation2,
                child: roleOption(
                  context,
                  icon: Icons.supervised_user_circle,
                  title: 'Administrator',
                  color: Colors.green.shade700,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminLoginPage()));
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Third role option with animation
              SlideTransition(
                position: _animation3,
                child: roleOption(
                  context,
                  icon: Icons.person_outline,
                  title: 'Student',
                  color: Colors.orange.shade700,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentSignIn()));
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Fourth role option with animation
              SlideTransition(
                position: _animation4,
                child: roleOption(
                  context,
                  icon: Icons.account_balance_wallet_sharp,
                  title: 'Provisional Admission',
                  color: Colors.pink,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProvisionalAdmissionPage()));
                  },
                ),
              ),
              const Spacer(),
              const Text(
                "By selecting your role, you agree to our terms and conditions.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget roleOption(BuildContext context,
      {required IconData icon,
        required String title,
        required Color color,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(icon, size: 40, color: Colors.white),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
