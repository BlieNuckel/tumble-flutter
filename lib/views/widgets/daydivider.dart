import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayDividerWidget extends StatelessWidget {
  final String dayName;
  final String date;
  final bool firstDayDivider;

  const DayDividerWidget({Key? key, required this.dayName, required this.date, required this.firstDayDivider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: () {
        if (firstDayDivider) {
          return const EdgeInsets.only(top: 50);
        } else {
          return const EdgeInsets.only(top: 28);
        }
      }(),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Row(
        children: [
          Text(dayName + " " + date,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 17, fontWeight: FontWeight.w400)),
          Expanded(
              child: Divider(
            color: Theme.of(context).colorScheme.onBackground,
            indent: 6,
            thickness: 1,
          ))
        ],
      ),
    );
  }
}
