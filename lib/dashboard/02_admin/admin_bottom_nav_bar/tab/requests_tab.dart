import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'form/bonafied_form/fill_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: RequestsScreen(),
  ));
}

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Fill-up"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Fill This Form",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminDetailsScreen()));
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    image: const DecorationImage(
                        image: AssetImage("images/bonafied_document.jpg"),
                        fit: BoxFit.fill)),
                height: 200,
                width: 150,
                child: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.touch_app,
                    size: 35,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
