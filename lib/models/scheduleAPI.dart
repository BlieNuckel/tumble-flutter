import 'dart:convert';
import 'package:tumble/models/schedule.dart';
import 'package:http/http.dart' as http;

class ScheduleApi {
  static Future<List<Schedule>> getSchedule() async {
    var uri = Uri.https('kronox-app-backend.herokuapp.com', '/schedules');

    final response = await http.get(uri, headers: {
      "schedule": "p.TBSE2+2021+35+100+NML+en",
      "month": "*",
      "day": "*"
    });

    Map data = jsonDecode(response.body);

    List temp = [];

    // p.TBSE2+2021+35+100+NML+en?month=March&day=*

    // HERE WE IMPLEMENT THE SME PARSING FOUND IN SCHEDULELISTVIEWMODEL
    //
    //
    //

    return Schedule.scheduleFromSnapshot(temp);
  }
}
