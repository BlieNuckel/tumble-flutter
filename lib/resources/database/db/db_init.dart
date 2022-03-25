import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/interface/preferenceInterface.dart';

class DbInit {
  static Database? _db;
  static String scheduleTable = "Schedules";
  static String databaseName = "AppDb";
  static String preferenceTable = "Preferences";
  static String viewType = "view_type";
  static String theme = "theme";
  static String defaultSchool = "default_school";
  static String scheduleId = "schedule_id";
  static String preferenceId = "preference_id";
  static String jsonString = "json_string";
  static String cachedAt = "cached_at";

  static Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await init();
    return _db;
  }

  static init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, databaseName);
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreatePreference,
    );
    return db;
  }

  /* Create new table for databasse */
  static _onCreatePreference(Database db, int version) async {
    String createPreferenceTableQuery =
        "CREATE TABLE $preferenceTable ($preferenceId TEXT PRIMARY KEY, $viewType TEXT, $theme TEXT, $defaultSchool TEXT)";
    await db.execute(createPreferenceTableQuery);
    String createScheduleTableQuery =
        "CREATE TABLE $scheduleTable ($scheduleId TEXT PRIMARY KEY, $jsonString TEXT, $cachedAt TEXT)";
    await db.execute(createScheduleTableQuery);
  }

  close() {}
}
