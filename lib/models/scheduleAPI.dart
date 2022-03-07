import 'dart:convert';
import 'package:tumble/models/scheduleList/schedule.dart';
import 'package:tumble/models/scheduleList/dayDivider.dart';
import 'package:tumble/providers/backendProvider.dart';

class ScheduleApi {
  /// Returns a [List] that corresponds to the given [scheduleId].
  ///
  /// Actual return type is [List<Object>], but all items are instances
  /// of either [Schedule] or [DayDivider]
  static Future<List<Object>> getSchedule(String scheduleId) async {
    final response = await BackendProvider.getFullSchedule(scheduleId);

    List temp = [];

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

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
    }

    return scheduleFromSnapshot(temp);
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
}
