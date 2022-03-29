import 'package:tumble/resources/database/db/db_init.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';

import '../util/school_enum.dart';

class PreferenceDTO {
  String _preferenceViewType = 'schedule';
  String _preferenceTheme = 'null';
  SchoolEnum? _preferenceDefaultSchool;
  final String _preferenceId = DbInit.preferenceId;
  /* Add any other future preferences */

  PreferenceDTO(
      {String preferenceViewType = 'schedule',
      String preferenceTheme = 'null',
      SchoolEnum? preferenceDefaultSchool}) {
    _preferenceViewType = preferenceViewType;
    _preferenceTheme = preferenceTheme;
    _preferenceDefaultSchool = preferenceDefaultSchool;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> preferenceMap = {};
    preferenceMap["view_type"] = _preferenceViewType;
    preferenceMap["theme"] = _preferenceTheme;
    preferenceMap["preference_id"] = _preferenceId;
    preferenceMap["default_school"] = _preferenceDefaultSchool == null
        ? null
        : _preferenceDefaultSchool!.name;
    return preferenceMap;
  }

  /// Update global singleton object each
  /// update of attributes for current session
  void saveToDb() async {
    await PreferenceRepository.updatePreferences(this);
  }

  String get viewType => _preferenceViewType;

  String get theme => _preferenceTheme;

  SchoolEnum? get defaultSchool => _preferenceDefaultSchool;

  set viewType(String newViewType) {
    _preferenceViewType = newViewType;
    saveToDb();
  }

  set theme(String newTheme) {
    _preferenceTheme = newTheme;
    saveToDb();
  }

  set defaultSchool(SchoolEnum? newSchool) {
    if (newSchool == null) {
      _preferenceDefaultSchool = null;
      saveToDb();
      return;
    }
    _preferenceDefaultSchool = newSchool;
    saveToDb();
  }
}
