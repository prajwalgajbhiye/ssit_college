import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomExaminationForm extends StatelessWidget {
  final String nameText;

  final String detailsText;

  const CustomExaminationForm(
      {super.key, required this.nameText, required this.detailsText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            nameText,
            style: TextStyle(fontSize: 6),
          ),
          Text(
            detailsText,
            style: TextStyle(fontSize: 6),
          )
        ],
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  final String seriesNo;
  final String subjectName;

  const CustomTable({super.key, required this.seriesNo, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              height: MediaQuery.of(context).size.height*0.01,

              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black))),
              child: Text(seriesNo,style: TextStyle(fontSize: 6),)),
        ),
        Expanded(
          flex: 6,
            child: Container(
              height: MediaQuery.of(context).size.height*0.01,
              alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black))),
                child: Text(subjectName,style: TextStyle(fontSize: 6),)))
      ],
    );
  }
}
