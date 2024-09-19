import 'package:flutter/services.dart'; // Import for clipboard functionality
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/custom_class.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({super.key});

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  List<Map<String, String>> users = [];
  int containerCount = 0; // To keep track of the container numbers
  bool _isLoading = true; // To show loading indicator when fetching data
  bool _isCreating = false; // To show loading indicator during create

  @override
  void initState() {
    super.initState();
    _fetchContainersFromFirestore();
  }

  Future<void> _fetchContainersFromFirestore() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc('containers')
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();

        // Convert dynamic data to List<Map<String, String>>
        setState(() {
          users = List<Map<String, String>>.from(
              (data?['containers'] as List<dynamic>).map((container) =>
              Map<String, String>.from(container as Map<String, dynamic>)));
          containerCount = users.length;
          _isLoading = false; // Stop loading indicator once data is fetched
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading data: $e'),
        ),
      );
      setState(() {
        _isLoading = false; // Stop loading indicator on error
      });
    }
  }

  Future<void> _saveContainersToFirestore() async {
    try {
      // Save the users list as List<Map<String, dynamic>> because Firestore needs dynamic types
      await FirebaseFirestore.instance.collection('admin').doc('containers').set({
        'containers': users,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving data: $e'),
        ),
      );
    }
  }

  void _showCupertinoPopup(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return AnimatedPadding(
          padding: EdgeInsets.only(bottom: bottomInset),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: CupertinoPopupSurface(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 350,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 1,
                          right: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            CupertinoTextField(
                              controller: usernameController,
                              placeholder: 'Username',
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CupertinoTextField(
                              controller: passwordController,
                              placeholder: 'Password',
                              obscureText: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _isCreating
                                ? const CupertinoActivityIndicator() // Show loading indicator when creating
                                : CupertinoButton(
                              onPressed: () async {
                                if (usernameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  // Set creating state to true to show the indicator
                                  setState(() {
                                    _isCreating = true;
                                  });

                                  // Simulate a delay for 2 seconds to show loading
                                  await Future.delayed(
                                      const Duration(seconds: 2));

                                  // Save to local state
                                  this.setState(() {
                                    users.add({
                                      'username': usernameController.text,
                                      'password': passwordController.text,
                                    });
                                    containerCount++;
                                  });

                                  // Save to Firestore
                                  await _saveContainersToFirestore();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Admin added successfully!'),
                                    ),
                                  );

                                  Navigator.pop(context); // Close the popup
                                  setState(() {
                                    _isCreating = false; // Stop loading
                                  });
                                }
                              },
                              color: Colors.black,
                              child: const Text('Create'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Admin'),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(
        child: CupertinoActivityIndicator(), // Show loading while fetching data
      )
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return AnimatedUserContainer(
            user: users[index],
            containerNumber: index + 1,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCupertinoPopup(context);
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.add_box_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}