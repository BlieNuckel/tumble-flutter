import 'package:flutter/cupertino.dart';
import 'package:tumble/resources/database/db/hive_methods.dart';

import '../../../models/schedule.dart';

class ScheduleRepository {
  static var dbObject;

  static init() {
    dbObject = HiveMethods();
    dbObject.init();
  }

  static addSchedules(List<Schedule> schedules) => dbObject.addSchedules();

  static deleteSchedules(int scheduleId) =>
      dbObject.deleteSchedules(scheduleId);

  static getSchedules() => dbObject.getSchedules();

  static close() => dbObject.close();
}
