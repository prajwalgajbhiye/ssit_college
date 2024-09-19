import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ssit_college_app/splash_screen.dart';

// const apiKey = "AIzaSyD3J3pyGw5NSHqbif8MtKtUs1eF7aHDdm8";
// const projectId ="ssit-56fe5";

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD3J3pyGw5NSHqbif8MtKtUs1eF7aHDdm8",
          projectId: "ssit-56fe5",
          messagingSenderId: "21310800133",
          appId: "1:21310800133:web:8ece2cdae021b42a1cb76c",
      ));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
