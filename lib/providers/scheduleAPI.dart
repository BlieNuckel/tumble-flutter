import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tumble/models/schedule.dart';
import 'package:tumble/models/dayDivider.dart';
import 'package:tumble/models/week.dart';
import 'package:tumble/providers/backendProvider.dart';
import 'package:tumble/providers/localStorage.dart';
import 'package:tumble/service_locator.dart';

import '../models/tableModel.dart';
import '../resources/database/repository/schedule_repository.dart';

class ScheduleApi {
  static final localStorageService = locator<LocalStorageService>();

  static final Map<String, int> monthMap = {
    'january': 1,
    'february': 2,
    'march': 3,
    'april': 4,
    'may': 5,
    'june': 6,
    'july': 7,
    'august': 8,
    'september': 9,
    'october': 10,
    'november': 11,
    'december': 12,
  };

  static Future<TableEntry> getScheduleForDb(String scheduleId) async {
    final response = await BackendProvider.getFullSchedule(scheduleId);
    Map data = jsonDecode(utf8.decode(response.bodyBytes));
    return TableEntry(jsonString: json.encode(data), scheduleId: scheduleId);
  }

  /// Returns a [List] that corresponds to the given [scheduleId].
  ///
  /// Actual return type is [List<Object>], but all items are instances
  /// of either [Schedule] or [DayDivider]
  static Future<List<Object>> getSchedule(
      String scheduleId, BuildContext context) async {
    final response = await BackendProvider.getFullSchedule(scheduleId);

    List temp = [];

    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));

      Map years = data["schedule"]; // Strips the outer "schedule" map

      // Loops through each "String year, Map months" object
      years.forEach((year, months) {
        // Makes sure the key is not one of the String, String entries in the object
        if (year != "_id" && year != "cachedAt" && year != "baseUrl") {
          // Loops through each "String month, Map days" object found in the year objects
          months.forEach((month, days) {
            // Loops through each "String day, List event" object found in month objects
            days.forEach((day, events) {
              // Instantly adds all objects in the list to our temp list
              temp.addAll(events);
            });
          });
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Schedule not found",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }
    throw (Exception);
  }

  static Future<List<Week>> getWeekSplitSchedule(
      String scheduleId, BuildContext context) async {
    final List<Object> paddedList =
        await getPaddedSchedule(scheduleId, context);
    List<Week> parsedWeekList = [];

    int startOfWeek = 0;
    int endOfWeek;

    for (var i = 0; i < paddedList.length; i++) {
      final currentObj = paddedList[i];
      if (currentObj is DayDivider && currentObj.dayName == "Monday") {
        if (i > startOfWeek) {
          endOfWeek = i;
          parsedWeekList.add(Week.fromEventList(
              (paddedList[startOfWeek] as DayDivider).weekNumber!,
              paddedList.sublist(startOfWeek, endOfWeek)));
          startOfWeek = i;
        }
      }
    }
    return parsedWeekList;
  }

  static Future<List<Object>> getPaddedSchedule(
      String scheduleId, BuildContext context) async {
    final response = await BackendProvider.getFullSchedule(scheduleId);

    List temp = [];

    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));

      Map years = data["schedule"]; // Strips the outer "schedule" map

      // Loops through each "String year, Map months" object
      years.forEach((year, months) {
        // Makes sure the key is not one of the String, String entries in the object
        if (year != "_id" && year != "cachedAt" && year != "baseUrl") {
          // Loops through each "String month, Map days" object found in the year objects
          months.forEach((month, days) {
            final DateTime currentTime = DateTime.now();
            final int firstDayOfWeek =
                currentTime.day - (currentTime.weekday - 1);
            for (var i = 1;
                i <=
                    DateUtils.getDaysInMonth(int.parse(year), monthMap[month]!);
                i++) {
              if (currentTime.month == monthMap[month] && i < firstDayOfWeek) {
                continue;
              }

              if (days[i.toString()] != null) {
                if (days[i.toString()][0].containsKey("dayName") &&
                    days[i.toString()][0]["dayName"] == "Monday") {
                  days[i.toString()][0]["weekNumber"] = getWeekNumber(
                          DateTime(int.parse(year), monthMap[month]!, i))
                      .toString();
                }

                temp.addAll(days[i.toString()]);
              } else {
                temp.add({
                  "date": i.toString() + "/" + monthMap[month].toString(),
                  "dayName": DateFormat("EEEE")
                      .format(DateTime(int.parse(year), monthMap[month]!, i)),
                  "weekNumber": getWeekNumber(
                          DateTime(int.parse(year), monthMap[month]!, i))
                      .toString()
                });
                temp.add(null);
              }
            }
          });
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Schedule not found",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }
    throw (Exception);
  }

  /// Method to turn unknown [list] of Objects into correct
  /// instances of Schedule and DayDivider objects
  static List<Object> scheduleFromSnapshot(List list) {
    return list.map((data) {
      if (data.containsKey("dayName")) {
        return DayDivider.fromJson(data);
      }
      return Schedule.fromJson(data);
    }).toList();
  }

  static List<Object> paddedScheduleFromSnapshot(List list) {
    return list.map((data) {
      if (data == null) {
        return Object();
      } else if (data.containsKey("dayName")) {
        return DayDivider.fromJson(data);
      }
      return Schedule.fromJson(data);
    }).toList();
  }

  static getWeeksInYear(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  static int getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int weekOfYear = ((dayOfYear - date.weekday + 10) / 7).floor();

    if (weekOfYear < 1) {
      weekOfYear = getWeeksInYear(date.year - 1);
    } else if (weekOfYear > getWeeksInYear(date.year)) {
      weekOfYear = 1;
    }

    return weekOfYear;
  }

  static isExamCard(String cardTitle) {
    return cardTitle.toLowerCase().contains("exam") ||
        cardTitle.toLowerCase().contains("tenta");
  }

  static bool isFavorite(String scheduleId) {
    // We can store a state somewhere that we can hopefully just update as the "current schedule" which we can then check against the saved favorite
    return localStorageService.getScheduleFavorite() == scheduleId;
  }

  static bool isStarred() {
    return false;
  }

  static hasFavorite() {
    return localStorageService.getScheduleFavorite() != "" &&
        localStorageService.getScheduleFavorite() != "null";
  }

  static setFavorite(String scheduleId) {
    localStorageService.setScheduleFavorite(scheduleId);
  }
}
