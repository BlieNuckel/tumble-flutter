import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late final SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  setScheduleFavorite(String scheduleId) {
    _preferences.setString("schedule_id", scheduleId);
  }

  String getScheduleFavorite() {
    print(_preferences.get("schedule_id").toString());
    return _preferences.get("schedule_id").toString();
  }
}
