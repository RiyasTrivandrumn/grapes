import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grapes_interview/Views/secondpage.dart';
import 'package:grapes_interview/model/workmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Dayshift> days = [
     Dayshift(day: "Sunday", shift: []),
    Dayshift(day: "Monday", shift: []),
    Dayshift(day: "Tuesday", shift: []),
    Dayshift(day: "Wednesday", shift: []),
    Dayshift(day: "Thursday", shift: []),
    Dayshift(day: "Friday", shift: []),
     Dayshift(day: "Saturday", shift: []),
  ];

  void navigateAndDisplaySelection(BuildContext context) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SecondPage(selectedDays: days.where((d) => d.shift.isNotEmpty).toList());
    }));
  }

 @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 160, 226, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 68, 177, 202),
        centerTitle: true,
        title: Text(
          'Schedule Working Time',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: w / 15),
        ),
       
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: h / 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w / 10),
                    child: Text(
                      "Day",
                      style: TextStyle(
                          fontSize: w / 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: w / 3),
                    child: Text(
                      "Shifts",
                      style: TextStyle(
                          fontSize: w / 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: days.length,
                itemBuilder: (context, index) {
                  var day = days[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: h / 170),
                    child: Container(
                      color: Colors.blue[50],
                      height: h / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.blue,
                                value: day.isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    day.isSelected = value!;
                                    if (!day.isSelected) {
                                      day.shift.clear();
                                    }
                                  });
                                },
                              ),
                              Text(
                                day.day,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 6,
                            children: ['Morning', 'Afternoon', '  Night ']
                                .map((shift) {
                              return FilterChip(
                                selectedColor:
                                    const Color.fromARGB(255, 160, 226, 240),
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: w / 100),
                                showCheckmark: false,
                                label: Text(shift),
                                selected: day.shift.contains(shift),
                                onSelected: day.isSelected
                                    ? (bool selected) {
                                        setState(() {
                                          if (selected) {
                                            day.shift.add(shift);
                                          } else {
                                            day.shift.remove(shift);
                                          }
                                        });
                                      }
                                    : null,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 87, 219, 249),
        onPressed: () => navigateAndDisplaySelection(context),
        label: Text(
          'Schedule',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: w / 20),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}