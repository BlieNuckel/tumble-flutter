import 'dart:developer';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/interface/preferenceInterface.dart';
import '../../../util/school_enum.dart';
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
    print(newPreferenceDTO.toMap().toString());
    Map<String, dynamic> oldPreferencesMap = (await fetchEntry()).toMap();
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
  Future<PreferenceDTO> getPreferences() async {
    return await fetchEntry();
  }

  Future<PreferenceDTO> fetchEntry() async {
    try {
      var dbClient = await DbInit.db;
      List<Map<String, dynamic>>? maps = await dbClient?.query(preferenceTable,
          columns: [preferenceId, viewType, theme, defaultSchool],
          where: '$preferenceId = $preferenceId');

      if (maps == null || maps.isEmpty) {
        await addPreferences(PreferenceDTO());
        return PreferenceDTO();
      }

      String? tempDefaultSchool = maps[0][defaultSchool];

      return PreferenceDTO(
          preferenceViewType: maps[0][viewType],
          preferenceTheme: maps[0][theme],
          preferenceDefaultSchool: tempDefaultSchool != null
              ? SchoolEnum.values.byName(tempDefaultSchool)
              : null);
    } catch (e) {
      log("Error in fetchEntry.", error: e);
      return PreferenceDTO();
    }
  }

  @override
  close() {}
}
