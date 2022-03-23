import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tumble/models/userPreferenceModel.dart';
import 'package:tumble/resources/database/interface/preferenceInterface.dart';

class PreferenceMethods implements PreferenceInterface {
  Database? _db;

  String databaseName = "AppDb";

  String preferenceTable = "Preferences";

  String viewType = "view_type";
  String theme = "theme";
  String id = "preference_id";

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
        "CREATE TABLE $preferenceTable ($id TEXT PRIMARY KEY, $viewType TEXT, $theme TEXT)";
    await db.execute(createTableQuery);
  }

  @override
  addPreferences(PreferenceEntry preferenceEntry) {
    // TODO: implement addPreference
    throw UnimplementedError();
  }

  @override
  deletePreferences(String preferenceId) {
    // TODO: implement deletePreferenceEntry
    throw UnimplementedError();
  }

  @override
  Future<PreferenceEntry?> getPreferences(String preferenceId) async {
    return await fetchEntry();
  }

  Future<PreferenceEntry?> fetchEntry() async {
    try {
      var dbClient = await db;
      List<Map<String, dynamic>>? maps = await dbClient?.query(preferenceTable,
          columns: [id, viewType, theme], where: '$id = ?', whereArgs: [id]);
      return PreferenceEntry(
          viewType: maps?[0][viewType], theme: maps?[0][theme]);
    } catch (e) {
      return null;
    }
  }

  @override
  close() {}
}
