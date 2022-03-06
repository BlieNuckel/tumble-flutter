class Schedule {
  final String start;
  final String end;
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
        start: json['start'] as String,
        end: json['end'] as String,
        course: json['course'] as String,
        lecturer: json['lecturer'] as String,
        location: json['location'] as String,
        title: json['title'] as String,
        color: json['color'] as String);
  }

  static List<Schedule> scheduleFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Schedule.fromJson(data);
    }).toList();
  }
}
