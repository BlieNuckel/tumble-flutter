import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tumble/models/schedule.dart';
import 'package:tumble/models/schedule_dto.dart';
import 'package:tumble/resources/database/db/db_init.dart';
import 'package:tumble/resources/database/interface/schedule_interface.dart';
import 'package:path/path.dart';
import '../../../models/schedule.dart';

class ScheduleMethods implements ScheduleInterface {
  String scheduleTable = DbInit.scheduleTable;
  String id = DbInit.scheduleId;
  String jsonString = DbInit.jsonString;
  String cachedAt = DbInit.cachedAt;

  @override
  addScheduleEntry(ScheduleDTO scheduleDTO) async {
    // ignore: non_constant_identifier_names
    var dbClient = await DbInit.db;
    await dbClient?.insert(scheduleTable, scheduleDTO.toMap());
  }

  @override
  close() {}

  @override
  Future<bool> deleteSchedules(String scheduleId) async {
    try {
      var dbClient = await DbInit.db;
      int? rowsAffected = await dbClient
          ?.delete(scheduleTable, where: "$id = ?", whereArgs: [scheduleId]);
      return rowsAffected != null && rowsAffected != 0;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ScheduleDTO>?> getAllScheduleEntries() async {
    try {
      var dbClient = await DbInit.db;
      List<Map<String, dynamic>>? maps = await dbClient?.query(
        scheduleTable,
        columns: [id, jsonString, cachedAt],
      );
      List<ScheduleDTO> elementList = [];
      /* Gets all schedules from database */
      if (maps!.isNotEmpty) {
        for (Map map in maps) {
          elementList.add(map as ScheduleDTO);
        }
      }
      return elementList;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DateTime?> getScheduleCachedTime(String scheduleId) async {
    ScheduleDTO? scheduleDTO = await getScheduleEntry(scheduleId);
    if (scheduleDTO == null) return null;
    return DateTime.parse(scheduleDTO.cachedAt!);
  }

  @override
  Future<ScheduleDTO?> getScheduleEntry(scheduleId) async {
    try {
      var dbClient = await DbInit.db;
      List<Map<String, dynamic>>? maps = await dbClient?.query(scheduleTable,
          columns: [id, jsonString, cachedAt],
          where: '$id = ?',
          whereArgs: [scheduleId]);
      return ScheduleDTO(
          jsonString: maps?[0][jsonString],
          scheduleId: scheduleId,
          cachedAt: maps?[0][cachedAt]);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> deleteAllSchedules() async {
    var dbClient = await DbInit.db;
    return await dbClient?.delete(scheduleTable);
  }
}
