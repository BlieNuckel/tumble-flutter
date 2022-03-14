class DayDivider {
  final String dayName;
  final String date;
  final String? weekNumber;

  DayDivider({required this.dayName, required this.date, this.weekNumber});

  factory DayDivider.fromJson(dynamic dayDividerObject) {
    return DayDivider(
        dayName: dayDividerObject['dayName'] as String,
        date: dayDividerObject['date'] as String,
        weekNumber: dayDividerObject['weekNumber']);
  }
}
