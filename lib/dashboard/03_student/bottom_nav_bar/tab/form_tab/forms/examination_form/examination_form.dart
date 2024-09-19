import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../components/form_custom_class.dart';

void main() {
  runApp(const MaterialApp(
    home: ExaminationForm(),
  ));
}

class ExaminationForm extends StatelessWidget {
  const ExaminationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Stack(
                  children: [
                    Positioned(
                        right: 10,
                        top: 90,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              height: 80,
                              width: 70,
                              // color: Colors.red,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(color: Colors.black),
                                      bottom: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black))),
                              height: 20,
                              width: 70,
                              // color: Colors.red,
                            ),
                          ],
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "(314) Swaminarayan Siddhanta Institute of Technology, Nagpur",
                            style: TextStyle(
                                fontFamily: "CollageNameFonts",
                                fontWeight: FontWeight.bold,
                                fontSize: 8),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/rtmnu_logo.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Center(
                          child: Text(
                            "RASHTRASANT TUKADOJI MAHARAJ NAGPUR UNIVERSITY, NAGPUR",
                            style: TextStyle(fontSize: 8),
                          ),
                        ),
                        const Center(
                          child: Text(
                            "EXAMINATION FORM",
                            style: TextStyle(
                                fontSize: 8,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomExaminationForm(
                          nameText: 'Name Of Examination',
                          detailsText:
                              '___________________________________________________',
                        ),
                        const CustomExaminationForm(
                          nameText: 'Enrollment No. / PRN: ',
                          detailsText:
                              '__________________________________________________',
                        ),
                        const CustomExaminationForm(
                          nameText:
                              'Students Details: Regular / Ex-Student / Old-Ex-Student: ',
                          detailsText: '_________________',
                        ),
                        const CustomExaminationForm(
                          nameText: 'Session: Winter / Summer : ',
                          detailsText:
                              '_____________________________________________',
                        ),
                        const CustomExaminationForm(
                          nameText: 'First Name: ',
                          detailsText:
                              '____________________________________________________________',
                        ),
                        const CustomExaminationForm(
                          nameText: 'Middle Name: ',
                          detailsText:
                              '__________________________________________________________',
                        ),
                        const CustomExaminationForm(
                          nameText: 'Last Name: ',
                          detailsText:
                              '____________________________________________________________',
                        ),
                        const Row(
                          children: [
                            CustomExaminationForm(
                              nameText: 'Mother Name: ',
                              detailsText: '_____________________________',
                            ),
                            CustomExaminationForm(
                              nameText: 'Date of Birth:',
                              detailsText: '____________________',
                            ),
                            CustomExaminationForm(
                              nameText: 'Mobile No.:',
                              detailsText: '__________________________',
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            CustomExaminationForm(
                              nameText: 'Category: ',
                              detailsText: '_________________',
                            ),
                            CustomExaminationForm(
                              nameText: 'Caste:',
                              detailsText: '_______________',
                            ),
                            CustomExaminationForm(
                              nameText: 'Aadhar No.:',
                              detailsText:
                                  '______________________________________________________',
                            ),
                          ],
                        ),
                        const CustomExaminationForm(
                            nameText: "Email ID",
                            detailsText:
                                "__________________________________________________________________________________________________________"),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            textAlign: TextAlign.start,
                            "Subject Applied For",
                            style: TextStyle(fontSize: 6),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.112,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.black),
                                  bottom: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black))),
                          child: const Column(
                            children: [
                              CustomTable(
                                seriesNo: 'Sr.No',
                                subjectName: 'Subject Name',
                              ),
                              CustomTable(
                                seriesNo: '1',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '2',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '3',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '4',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '5',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '6',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '7',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '8',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '9',
                                subjectName: '',
                              ),
                              CustomTable(
                                seriesNo: '10',
                                subjectName: '',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
