// ignore: file_names
class TableEntry {
  final String jsonString;
  final String scheduleId;

  TableEntry({required this.jsonString, required this.scheduleId});

  Map<String, dynamic> toMap(TableEntry tableRow) {
    Map<String, dynamic> tableMap = {};
    tableMap["json_string"] = jsonString;
    tableMap["schedule_id"] = scheduleId;
    return tableMap;
  }
}
