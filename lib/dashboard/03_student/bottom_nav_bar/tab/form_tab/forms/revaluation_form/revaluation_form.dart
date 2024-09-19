import 'package:flutter/material.dart';
import 'package:ssit_college_app/components/colors.dart';

void main() {
  runApp(const RevaluationForm());
}

class RevaluationForm extends StatelessWidget {
  const RevaluationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor3,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  alignment : Alignment.center,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "images/rtmnu_logo.png",),fit: BoxFit.cover)),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    text:
                                        'RASHTRASANT TUKADOJI MAHARAJ NAGPUR UNIVERSITY\n',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            'APPLICATION FOR DIRECT REVALUATION\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            '(As per Ordinance No. 9 of 2014)',
                                        style: TextStyle(
                                            fontSize: 8.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'To,',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Controller of Examination,',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rashtrasant Tukadoji Maharaj',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Nagpur University, Nagpur',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Through',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'The Principle.',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("________________"),
                                  Text("________________"),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          const Text(
                            'Sir/Madam,',
                            style: TextStyle(
                                fontSize: 8.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5.0),
                          RichText(
                            text: const TextSpan(
                              text:
                                  'I, the undersigned examinee, subject this application for direct revaluation.\n',
                              style:
                                  TextStyle(fontSize: 8.0, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'I declare that I have read and understood the provisions of the ',
                                ),
                                TextSpan(
                                  text: 'Ordinance No. 9 of 2014',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      ' and I accept all the terms and conditions of the said Ordinance.\n',
                                ),
                                TextSpan(
                                  text:
                                      'I am paying the Fee of Rs. 160*/310*/ Processing Fee 75/-\n',
                                ),
                                TextSpan(
                                  text:
                                      'The details examination and paper(s) are as under:\n',
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPaperMarksRow(
                                  '(a) Name of Examinee (In Full)',
                                  '______________________________'),
                              const SizedBox(height: 5),
                              _buildPaperMarksRow('(B) Name of Examination',
                                  '______________________________'),
                              const SizedBox(height: 5),
                              _buildPaperMarksRow('(c) Year of Examination',
                                  'Summer/Winter ______________'),
                              const SizedBox(height: 5),
                              _buildPaperMarksRow(
                                  '(d) Roll No.                                 ',
                                  '______________________________'),
                              const SizedBox(height: 5),
                              _buildPaperMarksRow('(e) Enrollment No.',
                                  '______________________________'),
                              const SizedBox(height: 5),
                              _buildPaperMarksRow('(f) Papers in which applied',
                                  "(i) Marks obtained ____________"),
                              const SizedBox(height: 5),
                              _buildPaperMarksRow('  for direct revaluation',
                                  '(ii) Marks obtained ___________'),
                              const SizedBox(height: 5),
                              const Text(
                                'The attested copy of the mark sheet is enclosed herewith.',
                                style: TextStyle(fontSize: 8),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'I declare that the above information is true and correct to the best of my knowledge.',
                                style: TextStyle(fontSize: 8),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                '*This information be invariably given.',
                                style: TextStyle(fontSize: 8),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    children: [
                                      Text(
                                        "Place: ___________",
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Date: ____________",
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(""))),
                                        height: 25,
                                        width: 100,
                                        // color: Colors.red,
                                      ),
                                      const Text(
                                        "Signature Of Applicant",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                '* Including Rs. 10/- as application fees.',
                                style: TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 5,
                            thickness: 2,
                          ),
                          const SizedBox(height: 5.0),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "For College Use",
                                  style: TextStyle(
                                      fontSize: 8, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              RichText(
                                text: const TextSpan(
                                  text:
                                      'The application is received with fee of Rs.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 8),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "_____________/-",
                                        style: TextStyle(fontSize: 8)),
                                    TextSpan(text: 'in Cash/ D.D. No.'),
                                    TextSpan(
                                        text: "______________",
                                        style: TextStyle(fontSize: 8)),
                                    TextSpan(
                                        text: 'dated',
                                        style: TextStyle(fontSize: 8)),
                                    TextSpan(
                                        text: '___________',
                                        style: TextStyle(fontSize: 8)),
                                    TextSpan(
                                        text: 'drawn on',
                                        style: TextStyle(fontSize: 8)),
                                    TextSpan(
                                        text: '___________________________',
                                        style: TextStyle(fontSize: 8)),
                                    TextSpan(
                                        text:
                                            "Bank and on scrutiny the application is found to be in order.",
                                        style: TextStyle(fontSize: 8))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              const Text(
                                "The application for direct revaluation was submitted to the University through our college.Hence forwarded",
                                style: TextStyle(fontSize: 8),
                              ),
                              const SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    children: [
                                      Text(
                                        "Place: ___________",
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Date: ____________",
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 100,
                                        // color: Colors.red,
                                      ),
                                      const Text(
                                        "Principal",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )

                          // Add more widgets to replicate the exact UI as needed
                        ],
                      ),
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

Widget _buildPaperMarksRow(String paper, String marks) {
  return Row(
    // crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        flex: 6,
        child: Text(
          paper,
          style: const TextStyle(fontSize: 8),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Text(
          ":",
          style: TextStyle(fontSize: 8),
        ),
      ),
      Expanded(
        flex: 5,
        child: Text(
          marks,
          style: const TextStyle(fontSize: 8),
        ),
      ),
    ],
  );
}
