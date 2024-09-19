import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: EnrolmentForm(),
  ));
}

class EnrolmentForm extends StatelessWidget {
  const EnrolmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/rtmnu_logo.png"),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "RASHTRASANT TUKADOJI MAHARAJ NAGPUR UNIVERSITY",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 8),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "ENROLMENT FORM - 2023-2024",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 8),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Enrolment No.	RTMNU /:- ",
                            style: TextStyle(
                                fontSize: 6, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "________________________",
                            style: TextStyle(
                                fontSize: 6, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "(First Semester Master of Business Administration)(MBA)(Out Come Based)(CBCS)",
                          style: TextStyle(
                              fontSize: 6, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To,",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 6, fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    '''The Registrar
Rashtrasant Tukadoji Maharaj Nagpur University,
Nagpur
''',
                                    style: TextStyle(fontSize: 6),
                                  ),
                                ),
                                Text(
                                  "Sir,",
                                  style: TextStyle(fontSize: 6),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    '''I desire to enroll in Rashtrasant Tukadoji Maharaj Nagpur University as a regular
student. My details are as follows :-

''',
                                    style: TextStyle(fontSize: 6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "images/transparent_ssit_logo.png"),
                                        fit: BoxFit.cover)),
                              ),
                              const Text(
                                "Photo Of Student",
                                style: TextStyle(fontSize: 6),
                              )
                            ],
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "College Name :-",
                            style: TextStyle(fontSize: 6),
                          ),
                          Text(
                            "(314) Swaminarayan Siddhanta Institute of Technology , Nagpur",
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.38,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "First Name :-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Middle Name :-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Last Name :-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Mother's Name:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Father's Full Name:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Postal Address:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "State:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Pin:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Permanent Address:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "State:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Pin:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Mobile No.:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Email ID :-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Date Of Birth:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "DOB (In Words)",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Category/Caste:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Religion:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              left: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Gender:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Nationality :-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Adhar Card Number :-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Name of Course:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Semester",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              left: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Medium",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text(
                                        "Subject To be Offered:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 12,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Examination Passed By Me:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Roll No.",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Year",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text(
                                        "Session",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 12,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Board / University:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Division",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Percentage%",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text(
                                        "Total",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text(
                                        "Subject Offered:-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text(
                                        "Marks Obtained :-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Physics",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "/100",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Chemistry",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "/100",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Mathematics",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text(
                                        "/100",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Biology",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "/100",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Vocational Subject",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "/100",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text(
                                        "",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Total Marks",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Percentage",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      )),
                                      child: const Text(
                                        "",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Date of Admission in College :- ",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Date of Payment",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "The above information furnished by me is true and correct",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        // height:
                                        //     MediaQuery.of(context).size.height *
                                        //         0.015,
                                        // color: Colors.red,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: const BoxDecoration(
                                          border: Border(

                                              right: BorderSide(
                                                  color: Colors.black))),
                                      child: const Text(
                                        "Date :-",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        decoration: BoxDecoration(
                                            border: Border(
                                            )),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width *
                                                  0.15,
                                              height:
                                            MediaQuery.of(context).size.height *
                                                0.017,),
                                            Text(
                                              "Signature",
                                              style: TextStyle(fontSize: 8),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
