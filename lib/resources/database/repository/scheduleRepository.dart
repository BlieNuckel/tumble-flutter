import 'package:tumble/models/schedule_dto.dart';
import 'package:tumble/resources/database/db/scheduleMethods.dart';

class ScheduleRepository {
  static var dbObject = ScheduleMethods();

  static addScheduleEntry(ScheduleDTO tableEntry) =>
      dbObject.addScheduleEntry(tableEntry);

  static Future<bool> deleteSchedules(String scheduleId) =>
      dbObject.deleteSchedules(scheduleId);

  static Future<List<ScheduleDTO>?> getAllScheduleEntries() =>
      dbObject.getAllScheduleEntries();

  static Future<ScheduleDTO?> getScheduleEntry(String scheduleId) =>
      dbObject.getScheduleEntry(scheduleId);

  static Future<DateTime?> getScheduleCachedTime(String scheduleId) =>
      dbObject.getScheduleCachedTime(scheduleId);

  static close() => dbObject.close();

  static Future<int?> deleteAllSchedules() => dbObject.deleteAllSchedules();
}
