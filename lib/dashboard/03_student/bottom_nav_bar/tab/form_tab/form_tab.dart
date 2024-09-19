import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssit_college_app/components/colors.dart';

import '../../../../../components/custom_class.dart';
import 'forms/bonafied/bonafied.dart';
import 'forms/bonafied/details.dart';

import 'forms/enrolment_form/enrolment_form.dart';
import 'forms/exam_form.dart';
import 'forms/examination_form/examination_form.dart';
import 'forms/revaluation_form/revaluation_details.dart';
import 'forms/revaluation_form/revaluation_form.dart'; // Assume this contains FormContainer class

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  // List of forms with corresponding screen references
  final List<Map<String, dynamic>> formItems = [
    {
      'formName': 'Enrolment Form',
      'formImage': 'images/ssit_collage_image_for_director_login_page.JPG',
      'screen': const EnrolmentForm(),
    },

    {
      'formName': 'Revaluation Form',
      'formImage': 'images/ssit_collage_image_for_director_login_page.JPG',
      'screen': const EnterRevaluationFormDetails(),
    },
    {
      'formName': 'Examination Form',
      'formImage': 'images/ssit_collage_image_for_director_login_page.JPG',
      'screen': const ExaminationForm(),
    },
    {
      'formName': 'Admission Form 1',
      'formImage': 'images/ssit_collage_image_for_director_login_page.JPG',
      'screen': const StudentDetailsScreen(),
    },
  ];

  // Single function to handle navigation
  void _navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToForm(int index) {
    _navigateToScreen(formItems[index]['screen']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form Screen",
        ),
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // Dark background
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            // PageView for form images
            SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.9,
              child: PageView.builder(
                controller: _pageController,
                itemCount: formItems.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FormContainer(
                      formName: formItems[index]['formName']!,
                      formImage: formItems[index]['formImage']!,
                      onTap: () => _navigateToForm(index),
                      backgroundColor: Colors.blueAccent,
                      // Add a custom dark color
                      textColor: Colors.white,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(formItems.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.orange : Colors.grey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            // NoticeContainer and ListFormContainer widgets
            //  Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //      Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //       child: NoticeContainer(
            //         noticeText: 'Important Forms',
            //         backgroundColor:Colors.grey.shade900 , // Darker color
            //         textColor: Colors.white,
            //       ),
            //     ),
            //      const SizedBox(height: 10),
            //     ListFormContainer(
            //       backgroundColor: Colors.lime.shade50,
            //       textColor: Colors.black,
            //     ),
            //     ListFormContainer(
            //       backgroundColor: Colors.lime.shade50,
            //       textColor: Colors.black,
            //     ),
            //      const SizedBox(height: 20),
            //      Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //       child: NoticeContainer(
            //         noticeText: 'Other Forms',
            //         backgroundColor:Colors.grey.shade900 , // Darker color
            //         textColor: Colors.white,
            //       ),
            //     ),
            //      const SizedBox(height: 10),
            //     ListFormContainer(
            //       backgroundColor: Colors.lime.shade50,
            //       textColor: Colors.black,
            //     ),
            //     ListFormContainer(
            //       backgroundColor: Colors.lime.shade50,
            //       textColor: Colors.black,
            //     ),
            //     ListFormContainer(
            //       backgroundColor: Colors.lime.shade50,
            //       textColor: Colors.black,
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
