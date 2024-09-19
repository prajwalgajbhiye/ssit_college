import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  // Dummy list of 03_student forms data
  final List<Map<String, String>> studentForms = [
    {
      'name': 'Admission Form 1',
      'formType': '',
      'date': '2024-09-01',
    },
    {
      'name': 'Admission Form 2',
      'formType': '',
      'date': '2024-08-25',
    },
    {
      'name': 'Admission Form 3',
      'formType': '',
      'date': '2024-08-15',
    },
    {
      'name': 'Admission Form 4',
      'formType': '',
      'date': '2024-08-05',
    },
    {
      'name': 'Admission Form 1',
      'formType': '',
      'date': '2024-09-01',
    },
    {
      'name': 'Admission Form 2',
      'formType': '',
      'date': '2024-08-25',
    },
    {
      'name': 'Admission Form 3',
      'formType': '',
      'date': '2024-08-15',
    },
    {
      'name': 'Admission Form 4',
      'formType': '',
      'date': '2024-08-05',
    },{
      'name': 'Admission Form 1',
      'formType': '',
      'date': '2024-09-01',
    },
    {
      'name': 'Admission Form 2',
      'formType': '',
      'date': '2024-08-25',
    },
    {
      'name': 'Admission Form 3',
      'formType': '',
      'date': '2024-08-15',
    },
    {
      'name': 'Admission Form 4',
      'formType': '',
      'date': '2024-08-05',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Students\' Forms'),backgroundColor: Colors.grey.shade900,centerTitle: true,),
      body : CupertinoPageScaffold(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: studentForms.length,
            itemBuilder: (context, index) {
              final student = studentForms[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(CupertinoIcons.person, color: Colors.white),
                  ),
                  title: Text(
                    student['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${student['formType']}\nFilled on: ${student['date']}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  trailing:const  Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.white,
                  ),
                  onTap: () {
                    // Handle form tap, e.g., navigate to form details
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
