import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'students_document.dart';

class ProvisionalAdmissionStudentInfo extends StatefulWidget {
  const ProvisionalAdmissionStudentInfo({super.key});

  @override
  _ProvisionalAdmissionStudentInfoState createState() =>
      _ProvisionalAdmissionStudentInfoState();
}

class _ProvisionalAdmissionStudentInfoState
    extends State<ProvisionalAdmissionStudentInfo> {
  List<Map<String, dynamic>> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  // Function to fetch student data from Firestore
  Future<void> fetchStudents() async {
    try {
      QuerySnapshot admissionSnapshot = await FirebaseFirestore.instance
          .collection('provisional_admission')
          .get();

      List<Map<String, dynamic>> studentList = [];

      // For each document in the provisional_admission collection
      for (var admissionDoc in admissionSnapshot.docs) {
        // Fetch student_info subcollection
        QuerySnapshot studentInfoSnapshot = await admissionDoc.reference
            .collection('student_info')
            .get();

        // Add each student's data to the list
        for (var studentDoc in studentInfoSnapshot.docs) {
          final data = studentDoc.data() as Map<String, dynamic>;
          studentList.add({
            'full_name': data.containsKey('full_name') ? data['full_name'] : 'Unknown',
            'mobile_number': data.containsKey('mobile_number') ? data['mobile_number'] : 'Unknown',
            'email': data.containsKey('email') ? data['email'] : 'Unknown',
            'course': data.containsKey('course') ? data['course'] : 'Unknown',
          });
        }
      }

      setState(() {
        students = studentList;
        isLoading = false; // Stop showing the loading indicator
      });
    } catch (e) {
      print('Error fetching student data: $e');
      setState(() {
        isLoading = false; // Stop showing the loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provisional Admission Info'),
        backgroundColor: Colors.purple, // Customize the app bar color
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                "Total Number Of Students : ${students.length}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "BoldText"),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(
                        Icons.folder,
                        color: Colors.purple,
                        size: 40,
                      ),
                      title: Text(
                        students[index]['full_name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text('Tap to view details'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Pass the student details to the StudentDocument page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDocument(
                              fullName: students[index]['full_name'],
                              mobileNumber: students[index]['mobile_number'],
                              email: students[index]['email'],
                              course: students[index]['course'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
