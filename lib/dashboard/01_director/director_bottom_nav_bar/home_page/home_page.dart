import 'package:flutter/material.dart';
import 'package:ssit_college_app/dashboard/01_director/director_bottom_nav_bar/home_page/provisionl_admission_student_info/provisionl_admission_student_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple,),
      body: Column(
        children: [
          SizedBox(
              height: 150,
              width: 150,
              // color: Colors.red,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProvisionalAdmissionStudentInfo()));
                      },
                      child: const Icon(
                        Icons.folder, color: Colors.purple,
                        size: 100,
                      )),
                  const Text(
                    "Provisional Admission Student",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
