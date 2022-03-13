import '../../../models/schedule.dart';
import '../../../models/tableModel.dart';

abstract class ScheduleInterface {
  init();

  addSchedules(Future<TableEntry> tableRow);

  Future<List<Object>?> getAllSchedules();

  Future<Map<String, dynamic>?> getSchedule(String scheduleId);

  deleteSchedules(int scheduleId);

  close();
}
