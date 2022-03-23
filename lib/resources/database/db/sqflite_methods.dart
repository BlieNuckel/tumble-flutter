import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tumble/models/schedule.dart';
import 'package:tumble/models/scheduleModel.dart';
import 'package:tumble/resources/database/interface/schedule_interface.dart';
import 'package:path/path.dart';
import '../../../models/schedule.dart';

class ScheduleMethods implements ScheduleInterface {
  Database? _db;
  String databaseName = "AppDb";
  String scheduleTable = "Schedules";
  String id = "schedule_id";
  String jsonString = "json_string";
  String cachedAt = "cached_at";

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await init();
    return _db;
  }

  @override
  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, databaseName);
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateSchedule,
    );

    return db;
  }

  /* Create new table for databasse */
  _onCreateSchedule(Database db, int version) async {
    String createTableQuery =
        "CREATE TABLE $scheduleTable ($id TEXT PRIMARY KEY, $jsonString TEXT, $cachedAt TEXT)";
    await db.execute(createTableQuery);
  }

  @override
  addScheduleEntry(ScheduleDTO scheduleDTO) async {
    // ignore: non_constant_identifier_names
    final ScheduleDTO = scheduleDTO;
    var dbClient = await db;
    await dbClient?.insert(scheduleTable, ScheduleDTO.toMap(ScheduleDTO));
  }

  @override
  close() {}

  @override
  Future<bool> deleteSchedules(String scheduleId) async {
    try {
      var dbClient = await db;
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
      var dbClient = await db;

      List<Map<String, dynamic>>? maps = await dbClient?.query(
        scheduleTable,
        columns: [
          id,
          jsonString,
        ],
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
      var dbClient = await db;
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
}
