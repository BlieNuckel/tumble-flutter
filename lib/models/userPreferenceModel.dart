class PreferenceEntry {
  final String viewType;
  final String theme;
  /* Add any other future preferences */

  PreferenceEntry({required this.viewType, required this.theme});

  Map<String, dynamic> toMap(PreferenceEntry preferenceEntry) {
    Map<String, dynamic> preferenceMap = {};
    preferenceMap["view_type"] = viewType;
    preferenceMap["theme"] = theme;
    return preferenceMap;
  }
}
