import 'package:intl/intl.dart';

class Utilities {
  // Helper for parsing datetime from local storage
  static String formatDateString(String time) {
    DateTime dateTime = DateTime.parse(time);
    var formatter = DateFormat('dd/MM/yy');
    return formatter.format(dateTime);
  }
}
