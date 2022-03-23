import 'package:tumble/models/schedule_dto.dart';
import 'package:tumble/resources/database/db/scheduleMethods.dart';

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

  static deleteAllSchedules() => dbObject.deleteAllSchedules();
}
