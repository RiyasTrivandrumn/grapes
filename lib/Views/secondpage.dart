import 'package:flutter/material.dart';
import 'package:grapes_interview/model/workmodel.dart';

class SecondPage extends StatelessWidget {
  final List<Dayshift> selectedDays;

  const SecondPage({Key? key, required this.selectedDays}) : super(key: key);

  TableRow buildCustomizedRow(String content1, String content2) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(content1),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(content2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 160, 226, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 68, 177, 202),
        title: const Text("Selected Working Time"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Table(
            border: TableBorder.all(),
            defaultColumnWidth: const FixedColumnWidth(170),
            children: [
              buildCustomizedRow("Day", "Shift"),
             ...selectedDays.map((e) => buildCustomizedRow(e.day, e.shift.join(','))),
            ],
          ),
        ),
      ),
    );
  }
}
