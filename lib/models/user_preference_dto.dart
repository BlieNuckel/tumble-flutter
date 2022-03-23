class PreferenceDTO {
  final String? viewType;
  final String? theme;
  final String? defaultSchool;
  /* Add any other future preferences */

  PreferenceDTO({this.viewType, this.theme, this.defaultSchool});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> preferenceMap = {};
    preferenceMap["view_type"] = viewType;
    preferenceMap["theme"] = theme;
    preferenceMap["default_school"] = defaultSchool;
    return preferenceMap;
  }
}
