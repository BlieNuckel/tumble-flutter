import 'dart:developer';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/interface/preferenceInterface.dart';
import 'db_init.dart';

class PreferenceMethods implements PreferenceInterface {
  String preferenceTable = DbInit.preferenceTable;
  String viewType = DbInit.viewType;
  String theme = DbInit.theme;
  String defaultSchool = DbInit.defaultSchool;
  String preferenceId = DbInit.preferenceId;

  @override
  addPreferences(PreferenceDTO preferenceEntry) async {
    var dbClient = await DbInit.db;
    await dbClient?.insert(preferenceTable, preferenceEntry.toMap());
  }

  @override
  updatePreferences(PreferenceDTO newPreferenceDTO) async {
    Map<String, dynamic>? oldPreferencesMap = (await fetchEntry())?.toMap();
    if (oldPreferencesMap == null) {
      await addPreferences(PreferenceDTO());
    }
    oldPreferencesMap ??= PreferenceDTO().toMap();
    Map? newPreferencesMap = newPreferenceDTO.toMap();
    for (MapEntry element in newPreferencesMap.entries) {
      if (element.value != null) {
        oldPreferencesMap[element.key] = element.value;
      }
    }
    try {
      var dbClient = await DbInit.db;
      dbClient?.update(
        preferenceTable,
        oldPreferencesMap,
        where: '$preferenceId = $preferenceId',
      );
    } on FormatException catch (e) {
      print(e);
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
      var dbClient = await DbInit.db;
      List<Map<String, dynamic>>? maps = await dbClient?.query(preferenceTable,
          columns: [preferenceId, viewType, theme, defaultSchool], where: '$preferenceId = $preferenceId');
      return PreferenceDTO(
          viewType: maps?[0][viewType], theme: maps?[0][theme], defaultSchool: maps?[0][defaultSchool]);
    } catch (e) {
      log("Error in fetchEntry.", error: e);
      return null;
    }
  }

  @override
  close() {}
}
