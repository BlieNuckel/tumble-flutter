import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/interface/preferenceInterface.dart';

class PreferenceMethods implements PreferenceInterface {
  Database? _db;
  String databaseName = "AppDb";
  String preferenceTable = "Preferences";
  String viewType = "view_type";
  String theme = "theme";
  String defaultSchool = "default_school";
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
    print("DONE WITH PREFERENCE INIT");
    return db;
  }

  /* Create new table for databasse */
  _onCreateSchedule(Database db, int version) async {
    String createTableQuery =
        "CREATE TABLE $preferenceTable ($id TEXT PRIMARY KEY, $viewType TEXT, $theme TEXT, $defaultSchool TEXT)";
    await db.execute(createTableQuery);
  }

  @override
  addPreferences(PreferenceDTO preferenceEntry) {
    // TODO: implement addPreference
    throw UnimplementedError();
  }

  @override
  updatePreferences(PreferenceDTO newPreferenceDTO) async {
    Map<String, dynamic>? oldPreferencesMap = (await fetchEntry())?.toMap();
    oldPreferencesMap ??= PreferenceDTO().toMap();
    Map? newPreferencesMap = newPreferenceDTO.toMap();
    for (MapEntry element in newPreferencesMap.entries) {
      if (element.value != null) {
        oldPreferencesMap[element.key] = element.value;
      }
    }
    try {
      var dbClient = await db;
      dbClient?.update(
        preferenceTable,
        oldPreferencesMap,
        where: '$id = $id',
      );
    } on FormatException {
      return null;
    }
  }

  @override
  deletePreferences(String preferenceId) {
    // TODO: implement deletePreferenceDTO
    throw UnimplementedError();
  }

  @override
  Future<PreferenceDTO?> getPreferences() async {
    return await fetchEntry();
  }

  Future<PreferenceDTO?> fetchEntry() async {
    try {
      var dbClient = await db;
      List<Map<String, dynamic>>? maps =
          await dbClient?.query(preferenceTable, columns: [id, viewType, theme, defaultSchool], where: '$id = $id');
      return PreferenceDTO(
          viewType: maps?[0][viewType], theme: maps?[0][theme], defaultSchool: maps?[0][defaultSchool]);
    } catch (e) {
      return null;
    }
  }

  @override
  close() {}
}
