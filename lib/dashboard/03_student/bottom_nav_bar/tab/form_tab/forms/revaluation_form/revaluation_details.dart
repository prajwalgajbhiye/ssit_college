import 'package:flutter/material.dart';
import 'package:ssit_college_app/components/colors.dart';
import 'package:ssit_college_app/dashboard/03_student/bottom_nav_bar/tab/form_tab/forms/revaluation_form/revaluation_form.dart';

void main() {
  runApp(const EnterRevaluationFormDetailsApp());
}

class EnterRevaluationFormDetailsApp extends StatelessWidget {
  const EnterRevaluationFormDetailsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revaluation Form',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
      home: const EnterRevaluationFormDetails(),
    );
  }
}

class EnterRevaluationFormDetails extends StatefulWidget {
  const EnterRevaluationFormDetails({Key? key}) : super(key: key);

  @override
  _EnterRevaluationFormDetailsState createState() =>
      _EnterRevaluationFormDetailsState();
}

class _EnterRevaluationFormDetailsState
    extends State<EnterRevaluationFormDetails> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController examNameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController enrollmentNoController = TextEditingController();
  final TextEditingController paper1Controller = TextEditingController();
  final TextEditingController paper2Controller = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor1,
      appBar: AppBar(
        title: const Text('Revaluation Form'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  '"Exams are like broken pens... pointless unless you’re prepared!"',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              _buildText(
                "Student! Fill this form carefully, your future might not depend on it, but better grades could!",
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Full Name:',
                icon: Icons.person,
                controller: nameController,
                validator: (value) =>
                value?.isEmpty ?? true ? 'Oops, forgot your name?' : null,
              ),
              _buildTextField(
                label: 'Name of Exam:',
                icon: Icons.book,
                controller: examNameController,
                validator: (value) => value?.isEmpty ?? true
                    ? 'The exam name is kind of important here...'
                    : null,
              ),
              _buildTextField(
                label: 'Year of Examination:',
                icon: Icons.calendar_today,
                controller: yearController,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Did the year just slip your mind?'
                    : null,
              ),
              _buildTextField(
                label: 'Roll Number:',
                icon: Icons.confirmation_number,
                controller: rollNoController,
                validator: (value) => value?.isEmpty ?? true
                    ? 'You need this to get the revaluation, trust me!'
                    : null,
              ),
              _buildTextField(
                label: 'Enrollment Number:',
                icon: Icons.format_list_numbered,
                controller: enrollmentNoController,
                validator: (value) =>
                value?.isEmpty ?? true ? 'Enrollment number, please!' : null,
              ),
              const SizedBox(height: 16),
              const Text(
                "Papers for direct revaluation:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16,),
              _buildTextField(
                label: '(i) Marks obtained in Paper 1:',
                icon: Icons.grade,
                controller: paper1Controller,
                validator: (value) => value?.isEmpty ?? true
                    ? 'How many marks for Paper 1?'
                    : null,
              ),
              _buildTextField(
                label: '(ii) Marks obtained in Paper 2:',
                icon: Icons.grade,
                controller: paper2Controller,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Paper 2 marks, don\'t forget them!'
                    : null,
              ),
              _buildTextField(
                label: 'Place:',
                icon: Icons.location_on,
                controller: placeController,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Where did you give this exam again?'
                    : null,
              ),
              _buildTextField(
                label: 'Date:',
                icon: Icons.date_range,
                controller: dateController,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Enter the date, it\'s important!'
                    : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RevaluationForm(),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          TextFormField(

            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              enabled: true,
              fillColor: Colors.greenAccent.shade100,
              prefixIcon: Icon(icon, color: Colors.teal),
              // labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }
}
