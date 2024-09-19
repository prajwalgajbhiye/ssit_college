import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExamForm(),
    );
  }
}

class ExamForm extends StatefulWidget {
  const ExamForm({super.key});

  @override
  State<ExamForm> createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  String? selectedFolderPath;

  Future<pw.Font> _loadFont(String path) async {
    final fontData = await rootBundle.load(path);
    return pw.Font.ttf(fontData);
  }

  Future<void> _generatePDF(BuildContext context) async {
    final robotoFont = await _loadFont('fonts/Roboto-Regular.ttf'); // Ensure the font is in your assets folder.

    if (selectedFolderPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a folder first.")),
      );
      return;
    }

    // Request storage permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Create a new PDF document
      final pdf = pw.Document();

      // Add the first container as the first page
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Container(
                  height: 700, // You need to provide fixed heights and widths
                  width: 600,
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.white,
                    // border: pw.Border.all(color: PdfColors.red),
                  ),
                  child: pw.Column(
                    children: [
                      pw.SizedBox(height: 20),
                      pw.Text(
                        'Swaminarayan Siddhanta Institute of Technology',
                        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Table(
                        border: pw.TableBorder.all(color: PdfColors.black),
                        columnWidths: const {
                          0: pw.FlexColumnWidth(2),
                          1: pw.FlexColumnWidth(2),
                          2: pw.FlexColumnWidth(2),
                        },
                        children: [
                          pw.TableRow(children: [
                             pw.Padding(
                              padding: pw.EdgeInsets.all(8.0),
                              child: pw.Text('Type of Exam:', style: pw.TextStyle(fontSize: 16)),
                            ),
                             pw.Padding(
                              padding: pw.EdgeInsets.all(8.0),
                              child: pw.Text('', style: pw.TextStyle(fontSize: 16)),
                            ),
                            pw.Padding(
                              padding:  pw.EdgeInsets.all(8.0),
                              child: pw.Column(
                                children: [
                                  pw.Container(
                                    height: 80,
                                    width: 60,
                                    color: PdfColors.grey300,
                                    child:  pw.Center(child: pw.Text('Photo')),
                                  ),
                                   pw.SizedBox(height: 10),
                                  pw.Container(
                                    height: 30,
                                    color: PdfColors.grey300,
                                    child:  pw.Center(child: pw.Text('Signature')),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Table(
                        border: pw.TableBorder.all(color: PdfColors.black),
                        columnWidths: const {
                          0: pw.FlexColumnWidth(2),
                          1: pw.FlexColumnWidth(3),
                        },
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('College Name with Code', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("Swaminarayana Sidhanta institute", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Course Name', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("MBA", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Year', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("2nd year", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Registration Number', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("36987412", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Roll Number', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("25542", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Candidate\'s Name', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("Samay raina", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Category', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("OBC", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Religion', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("Hindu", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Nationality', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("Indian", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Date of Birth', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("25/4/2003", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('College Name with Code', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("Swaminarayana Sidhanta institute", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Course Name', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("MBA", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Year', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("2nd year", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Registration Number', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("36987412", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Roll Number', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("25542", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Candidate\'s Name', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("Samay raina", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Category', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("OBC", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Religion', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("Hindu", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Nationality', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("Indian", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child: pw.Text('Date of Birth', style:  pw.TextStyle(fontSize: 5)),
                              ),
                              pw.Padding(
                                padding:  pw.EdgeInsets.all(8.0),
                                child:pw.Text("25/4/2003", style:  pw.TextStyle(fontSize: 5)),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Add the second container as the second page
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Text("Swaminarayan Siddhanta Institute of Technology",
                    style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text("Your second container content goes here..."),
              ],
            );
          },
        ),
      );

      try {
        Directory? directory;
        if (Platform.isAndroid) {
          directory = await getExternalStorageDirectory();
        } else {
          directory = await getApplicationDocumentsDirectory();
        }

        final path = '${directory!.path}/example.pdf';

        // Save the PDF
        final file = File(path);
        await file.writeAsBytes(await pdf.save());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("PDF saved in: $path")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving PDF: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission is required to save the PDF.")),
      );
    }
  }

  Future<void> _selectFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      setState(() {
        selectedFolderPath = selectedDirectory;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selected folder: $selectedDirectory")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No folder selected.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Swaminarayan Siddhanta Institute of Technology',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text("Name Of Student",textAlign: TextAlign.start),
                    // _buildHeaderTable(),
                     SizedBox(height: 10),
                    _buildDetailsTable(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    color: Colors.white, border: Border.all(color: Colors.red)),
                child: Stack(
                  children: [
                    const Positioned(
                        bottom: 30,
                        left: 20,
                        right: 20,
                        child: Text(
                          "Swaminarayan Siddhanta Institute of Technology",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.redAccent,
                              fontFamily: "CollageNameFonts"),
                        )),
                    const Positioned(
                        bottom: 10,
                        left: 30,
                        right: 10,
                        child: Text(
                          "College: Nagpur - Katol Highway Road, khapei (Kothe), Tah. Kalmeshwar, Nagpur - 441 501, Tel. +91-7118661100 \nEmail: infossitn@gmail.com, Website: www.nuvaedu.com",
                          style: TextStyle(
                              fontSize: 6,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildSubjectTable(),
                        const SizedBox(height: 10),
                        _buildDeclaration(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectFolder,
                child: const Text("Select Folder"),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    await _generatePDF(context);
                  },
                  child: const Text("Submit & Download"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildHeaderTable() {
  //   return Table(
  //     border: TableBorder.all(color: Colors.black),
  //     columnWidths: const {
  //       0: FlexColumnWidth(2),
  //       1: FlexColumnWidth(2),
  //       2: FlexColumnWidth(2),
  //     },
  //     children: [
  //       TableRow(children: [
  //         const Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: Text('Type of Exam:', style: TextStyle(fontSize: 16)),
  //         ),
  //         const Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: Text('', style: TextStyle(fontSize: 16)),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             children: [
  //               Container(
  //                 height: 80,
  //                 width: 60,
  //                 color: Colors.grey.shade300,
  //                 child: const Center(child: Text('Photo')),
  //               ),
  //               const SizedBox(height: 10),
  //               Container(
  //                 height: 30,
  //                 color: Colors.grey.shade300,
  //                 child: const Center(child: Text('Signature')),
  //               )
  //             ],
  //           ),
  //         ),
  //       ]),
  //     ],
  //   );
  // }

  Widget _buildDetailsTable() {
    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),

      },
      children: [
        _buildTableRow('Sr. No','Particulars', "Ammount in Rs.",),

        _buildTableRow('1','College Name with Code', "",),
        _buildTableRow("2",'Course Name', ''),
        _buildTableRow("3",'Year / Semester', ''),
        _buildTableRow("4",'Subjects', ''),
        _buildTableRow("5",'Registration Number', ''),
        _buildTableRow("6",'Roll Number', ''),
        _buildTableRow("7",'Candidate\'s Name', ''),
        _buildTableRow("8",'Father\'s / Mother\'s Name', ''),
        _buildTableRow("9",'Category', ''),
        _buildTableRow("10",'Sub-Category', ''),

      ],
    );
  }

  TableRow _buildTableRow(String label, String value, String No) {
    return TableRow(
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: const TextStyle(fontSize: 5)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: const TextStyle(fontSize: 5)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(No, style: const TextStyle(fontSize: 5)),
        ),
      ],
    );
  }

  Widget _buildSubjectTable() {
    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: {
        0: const FlexColumnWidth(3),
        1: const FlexColumnWidth(2),
      },
      children: [
        _buildTableRow("",'Subjects / Papers Details', ''),
        for (var i = 0; i < 5; i++) _buildTableRow("", 'Subject', 'Papers'),
      ],
    );
  }

  Widget _buildDeclaration() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Declaration by the Candidate',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'I, ___________________________ on _____________, solemnly declare that all the information provided in the form is true to the best of my knowledge. If any information is found untrue/false, the University may cancel my degree.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'अभ्यर्थी का नाम (Hindi में)',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 30),
              ],
            ),
            Column(
              children: [
                Text(
                  'Signature of the Candidate',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
