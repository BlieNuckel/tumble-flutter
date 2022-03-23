import 'package:flutter/cupertino.dart';
import 'package:tumble/models/scheduleModel.dart';
import 'package:tumble/resources/database/db/sqflite_methods.dart';
import '../../../models/schedule.dart';

class ScheduleRepository {
  static var dbObject;

  static init() {
    dbObject = ScheduleMethods();
    dbObject.init();
  }

  static addScheduleEntry(ScheduleDTO tableEntry) =>
      dbObject.addSchedules(tableEntry);

  static deleteSchedules(String scheduleId) =>
      dbObject.deleteSchedules(scheduleId);

  static getAllScheduleEntries() => dbObject.getAllScheduleEntries();

  static getScheduleEntry(String scheduleId) =>
      dbObject.getScheduleEntry(scheduleId);

  static getScheduleCachedTime(String scheduleId) =>
      dbObject.getScheduleCachedTime(scheduleId);

  static close() => dbObject.close();
}
