import '../../../models/scheduleList/schedule.dart';

abstract class ScheduleInterface {
  init();

  addSchedules(List<Schedule> schedules);

  Future<List<List<Schedule>>> getSchedules();

  deleteSchedules(int scheduleId);

  close();
}
