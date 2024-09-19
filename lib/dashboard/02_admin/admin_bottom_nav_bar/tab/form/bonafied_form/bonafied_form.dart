import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class AdminCertificateScreen extends StatelessWidget {
  final String fullName;
  final String category;
  final String purpose;
  final String dateOfBirth;
  final String collageYear;
  final String referenceNo;
  final String academicSession;

  const AdminCertificateScreen({
    Key? key,
    required this.fullName,
    required this.category,
    required this.purpose,
    required this.dateOfBirth,
    required this.collageYear,
    required this.referenceNo,
    required this.academicSession,
  }) : super(key: key);

  // Method to get current date formatted
  String getCurrentDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  // Convert date into words
  String convertDateToWords(String date) {
    try {
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
      String day = _numberToWords(parsedDate.day);
      String month = DateFormat('MMMM').format(parsedDate);
      String year = _yearToWords(parsedDate.year);
      return '$day $month $year';
    } catch (e) {
      return 'Invalid Date'; // Fallback in case of any errors
    }
  }

  // Helper function to convert number to words (for days 1-31)
  String _numberToWords(int number) {
    List<String> numbersInWords = [
      'Zero', 'First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh', 'Eighth', 'Ninth', 'Tenth',
      'Eleventh', 'Twelfth', 'Thirteenth', 'Fourteenth', 'Fifteenth', 'Sixteenth', 'Seventeenth', 'Eighteenth', 'Nineteenth', 'Twentieth',
      'Twenty First', 'Twenty Second', 'Twenty Third', 'Twenty Fourth', 'Twenty Fifth', 'Twenty Sixth', 'Twenty Seventh', 'Twenty Eighth', 'Twenty Ninth', 'Thirtieth', 'Thirty First'
    ];
    return numbersInWords[number];
  }

  // Helper function to convert year to words
  String _yearToWords(int year) {
    String yearString = year.toString();
    String firstPart = yearString.substring(0, 2); // First two digits
    String secondPart = yearString.substring(2);   // Last two digits

    String firstPartInWords = '';
    String secondPartInWords = '';

    if (firstPart == '20') {
      firstPartInWords = 'Two Thousand';
    }

    // Converting the second part of the year to words
    int secondPartInt = int.parse(secondPart);
    if (secondPartInt == 0) {
      secondPartInWords = '';
    } else if (secondPartInt <= 20) {
      secondPartInWords = _numberToWords(secondPartInt).toLowerCase();
    } else {
      secondPartInWords = '${_numberToWords((secondPartInt ~/ 10) * 10)} ${_numberToWords(secondPartInt % 10).toLowerCase()}';
    }

    return secondPartInWords.isEmpty ? firstPartInWords : '$firstPartInWords $secondPartInWords';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Positioned(
                  left: 20,
                  top: 50,
                  child: Column(
                    children: [Icon(Icons.arrow_back_rounded), Text("Back")],
                  )),
            ),
            Positioned(
                top: 50,
                right: 20,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lime.shade100),
                  height: 50,
                  width: 300,
                  child: const Text(
                    "Bonafide Certificate",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                )),
            Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 1,
                            top: 1,
                            child:  SizedBox(
                              height: 40,
                              width: 40,
                              child: const Image(
                                  image: AssetImage("images/transparent_ssit_logo.png")),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sarvasiddhanta Education Society’s\n'
                                    'Swaminarayan Siddhanta Institute of Technology\n'
                                    'Affiliated to Rashtrasant Tukadoji Maharaj Nagpur University\n'
                                    'Nagpur-Katol Highway Road, Kharpi (Kothe),\n'
                                    'Tal: Kalmeshwar, Nagpur, Maharashtra-441501',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Center(
                                child: Text(
                                  '(Approved by AICTE & DTE and Affiliated by RTM Nagpur University, Nagpur)',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ref. No: SSIT/2024-25/$referenceNo',
                                      style: const TextStyle(fontSize: 10)),
                                  Text('Date: ${getCurrentDate()}',
                                      style: const TextStyle(fontSize: 10)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Center(
                                child: Text(
                                  'BONAFIDE CERTIFICATE',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                  text: 'This is to certify that ',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: fullName,
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                      ' is/was bonafide 03_student of this college studying in MBA $collageYear Year during the academic session $academicSession. '
                                          'According to the college record his/her date of birth is $dateOfBirth. '
                                          'In words: ${convertDateToWords(dateOfBirth)} and he/she belong to ',
                                    ),
                                    TextSpan(
                                      text: category,
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' category.',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'This bonafide certificate is issued for the purpose of ',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                purpose,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 40),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Signature of Principal',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Principal',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Swaminarayan Siddhanta Institute\nof Technology, Kalmeshwar\nNagpur-441501',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
