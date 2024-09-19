import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'documents.dart';

class ProvisionalAdmissionApp extends StatelessWidget {
  const ProvisionalAdmissionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: ProvisionalAdmissionPage(),
    );
  }
}

class ProvisionalAdmissionPage extends StatefulWidget {
  const ProvisionalAdmissionPage({super.key});

  @override
  _ProvisionalAdmissionPageState createState() =>
      _ProvisionalAdmissionPageState();
}

class _ProvisionalAdmissionPageState extends State<ProvisionalAdmissionPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otherCourseController = TextEditingController();

  bool _isLoading = false;
  bool _isImageLoaded = false;
  String selectedCourse = 'Select Course';
  bool isOtherSelected = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    // Load the image and listen to its completion
    final image = const AssetImage('images/ssit_clg_img.JPG');
    final ImageStream stream = image.resolve(ImageConfiguration.empty);
    stream.addListener(
      ImageStreamListener(
            (ImageInfo info, bool synchronousCall) {
          setState(() {
            _isImageLoaded = true;
          });
        },
        onError: (exception, stackTrace) {
          print('Error loading image: $exception');
        },
      ),
    );
  }

  Future<int> getCurrentCount() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('provisional_admission')
        .orderBy('number', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final lastNumber = snapshot.docs.first['number'];
      return lastNumber + 1;
    } else {
      return 1; // If no documents exist, start with 1
    }
  }

  Future<void> submitStudentData(BuildContext context) async {
    final fullName = nameController.text;
    final mobileNumber = mobileController.text;
    final email = emailController.text;
    final course = isOtherSelected ? otherCourseController.text : selectedCourse;

    if (fullName.isEmpty || mobileNumber.isEmpty || email.isEmpty || course.isEmpty || course == 'Select Course') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Error'),
            content: const Text('All fields are required.'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      int currentNumber = await getCurrentCount();
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('provisional_admission')
          .doc(currentNumber.toString()); // Use the number as document ID

      await docRef.set({
        'number': currentNumber,
      });

      await docRef.collection('student_info').add({
        'full_name': fullName,
        'mobile_number': mobileNumber,
        'email': email,
        'course': course,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DocumentUploadPage(
            userName: nameController.text, // Pass the user's name
            userMobile: mobileController.text, // Pass the user's mobile number
            userEmail: emailController.text, // Pass the user's email
          ),
        ),
      );
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: CupertinoActionSheet(
            title: const Text('Select Course'),
            actions: [
              CupertinoActionSheetAction(
                child: const Text('BA'),
                onPressed: () {
                  setState(() {
                    selectedCourse = 'BA';
                    isOtherSelected = false;
                  });
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('BCom'),
                onPressed: () {
                  setState(() {
                    selectedCourse = 'BCom';
                    isOtherSelected = false;
                  });
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('BSc'),
                onPressed: () {
                  setState(() {
                    selectedCourse = 'BSc';
                    isOtherSelected = false;
                  });
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Other'),
                onPressed: () {
                  setState(() {
                    selectedCourse = 'Other';
                    isOtherSelected = true;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Provisional Admission'),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/ssit_clg_img.JPG',
              fit: BoxFit.cover,
            ),
          ),
          if (_isImageLoaded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoTextField(
                    controller: nameController,
                    placeholder: 'Full Name',
                    padding: const EdgeInsets.all(16),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: mobileController,
                    placeholder: 'Mobile Number',
                    padding: const EdgeInsets.all(16),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: emailController,
                    placeholder: 'Email',
                    padding: const EdgeInsets.all(16),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _showActionSheet(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        border: Border.all(
                            color: CupertinoColors.extraLightBackgroundGray),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedCourse,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: CupertinoColors.black, fontSize: 25),
                          ),
                          const Icon(CupertinoIcons.chevron_down),
                        ],
                      ),
                    ),
                  ),
                  if (isOtherSelected)
                    const SizedBox(height: 16),
                  if (isOtherSelected)
                    CupertinoTextField(
                      controller: otherCourseController,
                      placeholder: 'Enter your course',
                      padding: const EdgeInsets.all(16),
                    ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: _isLoading
                            ? null
                            : () => submitStudentData(context),
                        color: Colors.orange,
                        child: _isLoading
                            ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoActivityIndicator(
                              radius: 12,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Please wait...',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                            : const Text(
                          'Submit & Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
