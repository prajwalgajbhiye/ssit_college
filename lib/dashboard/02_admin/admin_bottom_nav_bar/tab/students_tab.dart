import 'package:flutter/material.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Students Screen',
          style: TextStyle(fontSize: 24, color: Colors.orange),
        ),
      ),
    );
  }
}
