import 'package:intl/intl.dart';
import 'package:tumble/models/dayDivider.dart';
import 'package:tumble/models/schedule.dart';

class Week {
  final int weekNumber;
  final List<Schedule> events;

  Week({required this.weekNumber, required this.events});

  // factory Week.fromEventList(List<Object> events) {
  //   DateTime lastDate;
  //   for (var event in events) {
  //     if (event is DayDivider && event.dayName.toLowerCase() == "monday") {
  //       lastDate = DateFormat("dd/MM").parse(event.date);

  //     }
  //   }

  //   return Week(

  //   )
  // }

}
