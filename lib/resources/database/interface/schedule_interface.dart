import '../../../models/schedule.dart';
import '../../../models/schedule_dto.dart';

abstract class ScheduleInterface {
  init();

  addScheduleEntry(ScheduleDTO tableRow);

  Future<List<ScheduleDTO>?> getAllScheduleEntries();

  Future<ScheduleDTO?> getScheduleEntry(String scheduleId);

  deleteSchedules(String scheduleId);

  getScheduleCachedTime(String scheduleId);

  Future<int?> deleteAllSchedules();

  close();
}
