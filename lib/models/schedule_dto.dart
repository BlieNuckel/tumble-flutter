// ignore: file_names
class ScheduleDTO {
  final String jsonString;
  final String scheduleId;
  String? cachedAt;

  ScheduleDTO({required this.jsonString, required this.scheduleId, cachedAt});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tableMap = {};
    tableMap["json_string"] = jsonString;
    tableMap["schedule_id"] = scheduleId;
    cachedAt == null
        ? tableMap["cached_at"] = DateTime.now().toIso8601String()
        : tableMap["cached_at"] = cachedAt;
    return tableMap;
  }
}
