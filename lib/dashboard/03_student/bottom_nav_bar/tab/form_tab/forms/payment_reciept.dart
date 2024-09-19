import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ReceiptScreen(),
  ));
}

class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SWAMINARAYAN SIDDHANTA\nINSTITUTE OF TECHNOLOGY, NAGPUR',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),
            _buildRow('Name of Student:', 'Rahul M Pardhi'),
            _buildRow('Course MBA Year:', 'MBA 1st Year'),
            _buildRow('Category:', 'Open'),
            SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.black),
              columnWidths: {
                0: FlexColumnWidth(0.2),
                1: FlexColumnWidth(0.5),
                2: FlexColumnWidth(0.3),
              },
              children: [
                _buildTableRow('Sr. No.', 'Particulars', 'Amount in Rs.'),
                _buildTableRow('1', 'Prospectus Fees / Admission Fees', '1500'),
                _buildTableRow('2', 'Tuition Fees', ''),
                _buildTableRow('3', 'Immigration Fees', ''),
                _buildTableRow('4', 'Enrollment Fees', ''),
                _buildTableRow('5', 'Exam Fees', ''),
                _buildTableRow('6', 'Practical / Project Fees', ''),
                _buildTableRow('7', 'Uniform Fees', '1500'),
                _buildTableRow('8', 'Annual Student Activities Fees', ''),
                _buildTableRow('9', 'Processing Charges', ''),
                _buildTableRow('10', 'Misc. Other Fees', ''),
                _buildTableRow('', 'Total Amount', '3000'),
              ],
            ),
            SizedBox(height: 16),
            _buildRow('Payment towards:', 'Received Cash / Online'),
            _buildRow('Date:', '29-08-24'),
            _buildRow('Amount in Words:', 'Three Thousand Only'),
            SizedBox(height: 32),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Signature',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String srNo, String particulars, String amount) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(srNo, textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(particulars),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(amount, textAlign: TextAlign.center),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
