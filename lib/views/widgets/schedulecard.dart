import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tumble/providers/scheduleAPI.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final String course;
  final String lecturer;
  final String location;
  final String color;
  final DateTime start;
  final DateTime end;

  ScheduleCard(
      {required this.title,
      required this.course,
      required this.lecturer,
      required this.location,
      required this.color,
      required this.start,
      required this.end});

  @override
  Widget build(BuildContext context) {
    bool _isExamCard = ScheduleApi.isExamCard(title);

    Color _mainCardTextColor = () {
      if (_isExamCard) {
        return Theme.of(context).colorScheme.onPrimary;
      } else {
        return Theme.of(context).colorScheme.onSurface;
      }
    }();

    return Container(
        margin: const EdgeInsets.only(top: 5),
        child: Stack(
          children: [
            Container(
                height: 150,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, top: 15),
                margin: const EdgeInsets.only(top: 9, left: 20, right: 20),
                decoration: () {
                  if (!_isExamCard) {
                    return BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 1, offset: Offset(0, 1))]);
                  } else {
                    return BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 1, offset: Offset(0, 1))]);
                  }
                }(),
                child: FractionallySizedBox(
                    widthFactor: 0.85,
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        () {
                          if (title.length >= 50) {
                            return Text(title.substring(0, 46) + '...',
                                style: TextStyle(
                                  color: _mainCardTextColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                ));
                          } else {
                            return Text(
                              title,
                              style: TextStyle(
                                color: _mainCardTextColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }
                        }(),
                        Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: () {
                              if (course.length >= 60) {
                                return Text(course.substring(0, 56) + '...',
                                    style: TextStyle(
                                      color: _mainCardTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ));
                              } else {
                                return Text(course,
                                    style: TextStyle(
                                      color: _mainCardTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ));
                              }
                            }()),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                alignment: Alignment.bottomLeft,
                                child: Text(location,
                                    style: TextStyle(
                                        color: _mainCardTextColor, fontSize: 21, fontWeight: FontWeight.w100))))
                      ],
                    ))),
            Container(
              alignment: Alignment.center,
              width: 50,
              decoration: () {
                if (_isExamCard) {
                  return BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(10));
                } else {
                  return BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(10));
                }
              }(),
              margin: const EdgeInsets.only(left: 25),
              child: Text(
                DateFormat.Hm().format(start),
                style: () {
                  if (_isExamCard) {
                    return const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w300);
                  } else {
                    return TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary, fontSize: 13, fontWeight: FontWeight.w300);
                  }
                }(),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Container(
                alignment: Alignment.center,
                width: 50,
                decoration: () {
                  if (_isExamCard) {
                    return BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(10));
                  } else {
                    return BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(10));
                  }
                }(),
                margin: const EdgeInsets.only(right: 25, top: 149),
                child: Text(
                  DateFormat.Hm().format(end),
                  style: () {
                    if (_isExamCard) {
                      return const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w300);
                    } else {
                      return TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary, fontSize: 13, fontWeight: FontWeight.w300);
                    }
                  }(),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 9, right: 20),
                alignment: Alignment.topRight,
                child: Image(
                    width: 50,
                    height: 50,
                    image: const AssetImage("assets/images/cardBanner.png"),
                    color: Color(int.parse("ff" + color.replaceAll("#", ""), radix: 16))))
          ],
        ));
  }
}
