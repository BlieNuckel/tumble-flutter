import '../../../models/schedule.dart';
import '../../../models/tableModel.dart';

abstract class ScheduleInterface {
  init();

  addSchedules(TableEntry tableRow);

  Future<List<Object>?> getAllSchedules();

  Future<dynamic> getSchedule(String scheduleId);

  deleteSchedules(String scheduleId);

  getScheduleCachedTime(String scheduleId);

  close();
}
