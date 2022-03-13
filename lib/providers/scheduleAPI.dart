import 'dart:convert';
import 'package:date_util/date_util.dart';
import 'package:intl/intl.dart';
import 'package:tumble/models/schedule.dart';
import 'package:tumble/models/dayDivider.dart';
import 'package:tumble/providers/backendProvider.dart';
import 'package:tumble/providers/localStorage.dart';
import 'package:tumble/service_locator.dart';

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

  /// Returns a [List] that corresponds to the given [scheduleId].
  ///
  /// Actual return type is [List<Object>], but all items are instances
  /// of either [Schedule] or [DayDivider]
  static Future<List<Object>> getSchedule(String scheduleId) async {
    final response = await BackendProvider.getFullSchedule(scheduleId);

    List temp = [];

    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));

      Map years = data["schedule"]; // Strips the outer "schedule" map

      // Loops through each "String year, Map months" object
      years.forEach((year, months) {
        // Makes sure the key is not one of the String, String entries in the object
        if (year != "_id" && year != "cachedAt") {
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
    } else {}
    return scheduleFromSnapshot(temp);
  }

  static Future<List<Object>> getPaddedSchedule(String scheduleId) async {
    final response = await BackendProvider.getFullSchedule(scheduleId);

    List temp = [];

    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));

      Map years = data["schedule"]; // Strips the outer "schedule" map

      // Loops through each "String year, Map months" object
      years.forEach((year, months) {
        // Makes sure the key is not one of the String, String entries in the object
        if (year != "_id" && year != "cachedAt") {
          // Loops through each "String month, Map days" object found in the year objects
          months.forEach((month, days) {
            for (var i = 0; i < DateUtil().daysInMonth(monthMap[month], int.parse(year)); i++) {
              if (days[i.toString()] != null) {
                temp.addAll(days[i.toString()]);
              } else {
                temp.add({"date": i.toString().padLeft(2, '0') + monthMap[month].toString().padLeft(2, '0')});
                temp.add(null);
              }
            }

            // Loops through each "String day, List event" object found in month objects
            days.forEach((day, events) {
              // Instantly adds all objects in the list to our temp list
              temp.addAll(events);
            });
          });
        }
      });
    } else {}
    return paddedScheduleFromSnapshot(temp);
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
      if (data.containsKey("dayName")) {
        return DayDivider.fromJson(data);
      }
      return Schedule.fromJson(data);
    }).toList();
  }

  static isExamCard(String cardTitle) {
    return cardTitle.toLowerCase().contains("exam") || cardTitle.toLowerCase().contains("tenta");
  }

  static bool isFavorite(String scheduleId) {
    // We can store a state somewhere that we can hopefully just update as the "current schedule" which we can then check against the saved favorite
    return localStorageService.getScheduleFavorite() == scheduleId;
  }

  static bool isStarred() {
    return false;
  }

  static hasFavorite() {
    return localStorageService.getScheduleFavorite() != "" && localStorageService.getScheduleFavorite() != "null";
  }

  static setFavorite(String scheduleId) {
    localStorageService.setScheduleFavorite(scheduleId);
  }
}
