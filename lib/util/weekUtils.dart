import 'package:intl/intl.dart';

class WeekUtils {
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
}
