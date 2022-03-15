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

  static void saveCurrScheduleToDb(String scheduleId) async {
    ScheduleRepository.init();
    Response response = await BackendProvider.getFullSchedule(scheduleId);
    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));

      await ScheduleRepository.deleteSchedules(scheduleId);

      await ScheduleRepository.addSchedules(
          TableEntry(jsonString: json.encode(data), scheduleId: scheduleId));
    }
  }

  /// Returns a [List] that corresponds to the given [scheduleId].
  ///
  /// Actual return type is [List<Object>], but all items are instances
  /// of either [Schedule] or [DayDivider]
  ///
  static Future<List<Object>> getSchedule(
      String scheduleId, BuildContext context, bool padded) async {
    ScheduleRepository.init();
    List eventList = [];
    if (isFavorite(scheduleId)) {
      DateTime cacheTime =
          await ScheduleRepository.getScheduleCachedTime(scheduleId);

      if (DateTime.now().difference(cacheTime).inMinutes > 10) {
        saveCurrScheduleToDb(scheduleId);
      }

      Map? data = await ScheduleRepository.getSchedule(scheduleId);

      /* If database returns empty schedule we toast */
      if (data == null) {
        Fluttertoast.showToast(
            msg: "Schedule not found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
      } else {
        eventList = padded
            ? getPaddedList(data["schedule"])
            : getList(data["schedule"]);
      }
    } else {
      eventList = await webFetch(scheduleId, padded);
    }
    return padded
        ? paddedScheduleFromSnapshot(eventList)
        : scheduleFromSnapshot(eventList);
  }

  static Future<List<Week>> getWeekSplitSchedule(
      String scheduleId, BuildContext context) async {
    final List<Object> paddedList =
        await getSchedule(scheduleId, context, true);
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

  static List getPaddedList(years) {
    List temp = [];
    // Loops through each "String year, Map months" object
    years.forEach((year, months) {
      // Loops through each "String month, Map days" object found in the year objects
      months.forEach((month, days) {
        final DateTime currentTime = DateTime.now();
        final int firstDayOfWeek = currentTime.day - (currentTime.weekday - 1);
        for (var i = 1;
            i <= DateUtils.getDaysInMonth(int.parse(year), monthMap[month]!);
            i++) {
          if (currentTime.month == monthMap[month] && i < firstDayOfWeek) {
            continue;
          }

          if (days[i.toString()] != null) {
            if (days[i.toString()][0].containsKey("dayName") &&
                days[i.toString()][0]["dayName"] == "Monday") {
              days[i.toString()][0]["weekNumber"] =
                  getWeekNumber(DateTime(int.parse(year), monthMap[month]!, i))
                      .toString();
            }

            temp.addAll(days[i.toString()]);
          } else {
            temp.add({
              "date": i.toString() + "/" + monthMap[month].toString(),
              "dayName": DateFormat("EEEE")
                  .format(DateTime(int.parse(year), monthMap[month]!, i)),
              "weekNumber":
                  getWeekNumber(DateTime(int.parse(year), monthMap[month]!, i))
                      .toString()
            });
            temp.add(null);
          }
        }
      });
    });
    return temp;
  }

  static List getList(years) {
    List temp = [];
    // Loops through each "String year, Map months" object
    years.forEach((year, months) {
      // Loops through each "String month, Map days" object found in the year objects
      months.forEach((month, days) {
        // Loops through each "String day, List event" object found in month objects
        days.forEach((day, events) {
          // Instantly adds all objects in the list to our temp list
          temp.addAll(events);
        });
      });
    });
    return temp;
  }

  static Future<List> webFetch(String scheduleId, bool padded) async {
    Response response = await BackendProvider.getFullSchedule(scheduleId);

    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));
      Map years = data["schedule"];

      return padded ? getPaddedList(years) : getList(years);
    } else {
      Fluttertoast.showToast(
          msg: "Schedule not found",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      return [];
    }
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
