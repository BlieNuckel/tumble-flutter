import 'package:tumble/resources/database/db/db_init.dart';

class PreferenceDTO {
  final String? viewType;
  final String? theme;
  final String? defaultSchool;
  final String preferenceId = DbInit.preferenceId;
  /* Add any other future preferences */

  PreferenceDTO({this.viewType, this.theme, this.defaultSchool});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> preferenceMap = {};
    preferenceMap["view_type"] = viewType;
    preferenceMap["theme"] = theme;
    preferenceMap["preference_id"] = preferenceId;
    preferenceMap["default_school"] = defaultSchool;
    return preferenceMap;
  }
}
