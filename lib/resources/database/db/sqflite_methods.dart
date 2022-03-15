import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tumble/models/schedule.dart';
import 'package:tumble/models/tableModel.dart';
import 'package:tumble/resources/database/interface/schedule_interface.dart';
import 'package:path/path.dart';
import '../../../models/schedule.dart';

class HiveMethods implements ScheduleInterface {
  Database? _db;

  String databaseName = "ScheduleDb";

  String tableName = "Call_Schedules";

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
        "CREATE TABLE $tableName ($id TEXT PRIMARY KEY, $jsonString TEXT, $cachedAt TEXT)";
    await db.execute(createTableQuery);
  }

  @override
  addSchedules(TableEntry tableRow) async {
    final tableEntry = tableRow;
    var dbClient = await db;
    await dbClient?.insert(tableName, tableEntry.toMap(tableEntry));
  }

  @override
  close() {}

  @override
  Future<bool> deleteSchedules(String scheduleId) async {
    try {
      var dbClient = await db;
      int? rowsAffected = await dbClient
          ?.delete(tableName, where: "$id = ?", whereArgs: [scheduleId]);
      return rowsAffected != null && rowsAffected != 0;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Object>?> getAllSchedules() async {
    try {
      var dbClient = await db;

      List<Map<String, dynamic>>? maps = await dbClient?.query(
        tableName,
        columns: [
          id,
          jsonString,
        ],
      );
      List<Object> elementList = [];
      /* Gets all schedules from database */
      if (maps!.isNotEmpty) {
        for (Map map in maps) {
          elementList.add(map);
        }
      }
      return elementList;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<dynamic> getSchedule(String scheduleId) async {
    try {
      var dbClient = await db;

      List<Map<String, dynamic>>? maps = await dbClient?.query(tableName,
          columns: [id, jsonString, cachedAt],
          where: '$id = ?',
          whereArgs: [scheduleId]);

      if (maps!.isNotEmpty) {
        return jsonDecode(maps[0][jsonString]);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DateTime?> getScheduleCachedTime(String scheduleId) async {
    try {
      var dbClient = await db;

      List<Map<String, dynamic>>? maps = await dbClient?.query(tableName,
          columns: [id, jsonString, cachedAt],
          where: '$id = ?',
          whereArgs: [scheduleId]);
      if (maps!.isNotEmpty) {
        return DateTime.parse(maps[0][cachedAt]);
      }
      return null;
    } on FormatException {
      return null;
    }
  }
}
