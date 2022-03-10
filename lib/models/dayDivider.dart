class DayDivider {
  final String dayName;
  final String date;

  DayDivider({required this.dayName, required this.date});

  factory DayDivider.fromJson(dynamic dayDividerObject) {
    return DayDivider(
      dayName: dayDividerObject['dayName'] as String,
      date: dayDividerObject['date'] as String,
    );
  }
}
