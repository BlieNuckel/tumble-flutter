import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/db/preferenceMethods.dart';

class PreferenceRepository {
  static var dbObject = PreferenceMethods();

  static addPreferences(PreferenceDTO preferenceEntry) =>
      dbObject.addPreferences(preferenceEntry);

  static deletePreferences(String preferenceEntry) =>
      dbObject.deletePreferences(preferenceEntry);

  static Future<PreferenceDTO?> getPreferences() => dbObject.getPreferences();

  static updatePreferences(PreferenceDTO newPreferenceDTO) =>
      dbObject.updatePreferences(newPreferenceDTO);

  static close() => dbObject.close();
}
