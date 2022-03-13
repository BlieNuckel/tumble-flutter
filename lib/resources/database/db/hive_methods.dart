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
        "CREATE TABLE $tableName ($id TEXT PRIMARY KEY, $jsonString TEXT)";
    await db.execute(createTableQuery);
  }

  @override
  addSchedules(Future<TableEntry> tableRow) async {
    final tableEntry = await tableRow;
    var dbClient = await db;
    await dbClient?.insert(tableName, tableEntry.toMap(tableEntry));
  }

  @override
  close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  deleteSchedules(int scheduleId) {
    // TODO: implement deleteSchedules
    throw UnimplementedError();
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
  Future<Map<String, dynamic>?> getSchedule(String scheduleId) async {
    try {
      var dbClient = await db;

      List<Map<String, dynamic>>? maps = await dbClient?.query(tableName,
          columns: [
            id,
            jsonString,
          ],
          where: 'schedule_id = ?',
          whereArgs: [scheduleId]);

      if (maps!.isNotEmpty) {
        return maps[0];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
