import 'package:intl/intl.dart';
import 'package:tumble/models/dayDivider.dart';
import 'package:tumble/models/schedule.dart';

class Week {
  final String weekNumber;
  final List<Object> events;

  Week({required this.weekNumber, required this.events});

  factory Week.fromEventList(List<Object> events) {
    return Week(weekNumber: DateFormat("W").format((events[1] as Schedule).start), events: events);
  }
}
