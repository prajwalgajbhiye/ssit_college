import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../bottom_nav_bar.dart';
import 'bonafied_form.dart';

void main() {
  runApp(const AdminDetailsScreen());
}

class AdminDetailsScreen extends StatelessWidget {
  const AdminDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentDetailsForm(),
    );
  }
}

class StudentDetailsForm extends StatefulWidget {
  const StudentDetailsForm({super.key});

  @override
  _StudentDetailsFormState createState() => _StudentDetailsFormState();
}

class _StudentDetailsFormState extends State<StudentDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _referenceNOController = TextEditingController();

  String _selectedDate = "Select Date Of Birth";
  DateTime? _pickedDate;

  String _selectedCollageYear = '1st Year';
  String _selectedAcademicSession = '2023-2024';

  void _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _pickedDate = picked;
        _selectedDate = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _pickedDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminCertificateScreen(
            fullName: _fullNameController.text,
            category: _categoryController.text,
            purpose: _purposeController.text,
            dateOfBirth: _selectedDate,
            collageYear: _selectedCollageYear,
            referenceNo: _referenceNOController.text,
            academicSession: _selectedAcademicSession,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all the fields and select a date."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details Form"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminBottomNavBarApp()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedCollageYear,
                  decoration: const InputDecoration(
                    labelText: 'Select Year',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.school),
                  ),
                  items: ['1st Year', '2nd Year']
                      .map((year) => DropdownMenuItem(
                    value: year,
                    child: Text(year),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCollageYear = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedAcademicSession,
                  decoration: const InputDecoration(
                    labelText: 'Academic Session',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  items: ['2023-2024', '2024-2025']
                      .map((session) => DropdownMenuItem(
                    value: session,
                    child: Text(session),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAcademicSession = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _purposeController,
                  decoration: const InputDecoration(
                    labelText: 'Purpose',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.info_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the purpose';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _referenceNOController,
                  decoration: const InputDecoration(
                    labelText: 'Ref. NO',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.code),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the purpose';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => _pickDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.blueAccent),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit Form',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
