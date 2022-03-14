import 'package:flutter/material.dart';
import 'package:tumble/models/dayDivider.dart';
import 'package:tumble/models/schedule.dart';
import 'package:tumble/models/week.dart';
import 'package:tumble/views/widgets/weekEvent.dart';

class WeekWidget extends StatelessWidget {
  final Week week;

  const WeekWidget({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: week.events.length,
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            itemBuilder: ((context, index) {
              final currentObj = week.events[index];

              if (currentObj is DayDivider) {
                return Container(
                  padding: index == 0
                      ? const EdgeInsets.only(
                          top: 70,
                          bottom: 5,
                          left: 20,
                          right: 20,
                        )
                      : const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                          left: 20,
                          right: 20,
                        ),
                  child: Text(
                    currentObj.dayName + " " + currentObj.date,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else if (currentObj is Schedule) {
                if (index == week.events.length - 1) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: WeekEvent(
                        event: currentObj,
                      ));
                } else {
                  return WeekEvent(
                    event: currentObj,
                  );
                }
              } else {
                if (index == week.events.length - 1) {
                  return const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: WeekEvent(
                        empty: true,
                      ));
                } else {
                  return const WeekEvent(
                    empty: true,
                  );
                }
              }
            }),
          ),
          Positioned(
            right: 20,
            top: 80,
            child: Text(
              "w. " + week.weekNumber,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 20, fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
