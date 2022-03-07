class Schedule {
  final DateTime start;
  final DateTime end;
  final String course;
  final String lecturer;
  final String location;
  final String title;
  final String color;

  Schedule(
      {required this.start,
      required this.end,
      required this.course,
      required this.lecturer,
      required this.location,
      required this.title,
      required this.color});

  factory Schedule.fromJson(dynamic json) {
    return Schedule(
        start: toZonedTime(json['start']),
        end: toZonedTime(json['end']),
        course: json['course'] as String,
        lecturer: json['lecturer'] as String,
        location: json['location'] as String,
        title: json['title'] as String,
        color: json['color'] as String);
  }

  /// Generates a [DateTime] object with timezone consideration from a given [isoString]
  static DateTime toZonedTime(String isoString) {
    List<String> splitIsoString;

    if (isoString.contains("+")) {
      splitIsoString = isoString.split("+");
    } else if (isoString.contains("-")) {
      splitIsoString = isoString.split("+");
    } else {
      splitIsoString = ["00", "00:00"];
    }

    isoString = splitIsoString[0] + "+" + splitIsoString[1].replaceAll(":", "");

    DateTime isoDateTime = DateTime.parse(isoString).toLocal();

    return isoDateTime;
  }
}
