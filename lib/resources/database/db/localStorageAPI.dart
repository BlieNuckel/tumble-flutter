import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/util/school_enum.dart';

class LocalStorageService {
  late final SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void setScheduleFavorite(String scheduleId) {
    _preferences.setString("schedule_id", scheduleId);
  }

  String getScheduleFavorite() {
    return _preferences.get("schedule_id").toString();
  }

  void setSchoolDefault(SchoolEnum school) {
    _preferences.setString("school_id", school.name);
  }

  String getSchoolDefault() {
    return _preferences.get("school_id").toString();
  }
}
