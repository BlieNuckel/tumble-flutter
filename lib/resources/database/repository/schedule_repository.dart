import 'package:flutter/cupertino.dart';
import 'package:tumble/models/tableModel.dart';
import 'package:tumble/resources/database/db/hive_methods.dart';
import '../../../models/schedule.dart';

class ScheduleRepository {
  static var dbObject;

  static init() {
    dbObject = HiveMethods();
    dbObject.init();
  }

  static addSchedules(Future<TableEntry> tableEntry) =>
      dbObject.addSchedules(tableEntry);

  static deleteSchedules(int scheduleId) =>
      dbObject.deleteSchedules(scheduleId);

  static getAllSchedules() => dbObject.getAllSchedules();

  static getSchedule(String scheduleId) => dbObject.getSchedule(scheduleId);

  static close() => dbObject.close();
}
