import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('College Form'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            border: TableBorder.all(),
            children: [
              TableRow(children: [
                Text('First Name:'),
                Text('Middle Name:'),
                Text('Last Name:'),
                Text('Last Name:'),

              ]),
              TableRow(children: [
                Text('Last Name:'),
                TextField(),
                Text('Pin'),
                TextField(),
              ]),
              TableRow(children: [
                Text("Mother's Name:"),
                TextField(),
                Text("Father's Full Name:"),
                TextField(),
              ]),
              TableRow(children: [
                Text('Postal Address:'),
                TextField(),
                Text('State:'),
                TextField(),
              ]),
              TableRow(children: [
                Text('Permanent Address:'),
                TextField(),
                Text('State:'),
                TextField(),
              ]),
              // Add more TableRow widgets for other form fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
