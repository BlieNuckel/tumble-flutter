import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final String course;
  final String lecturer;
  final String location;
  final String color;
  ScheduleCard({
    required this.title,
    required this.course,
    required this.lecturer,
    required this.location,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
      height: 200,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))
              ]),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black),
          )),
    );
  }
}
