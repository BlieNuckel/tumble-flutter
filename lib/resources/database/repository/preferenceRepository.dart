import 'package:tumble/models/userPreferenceModel.dart';
import 'package:tumble/resources/database/db/preferenceMethods.dart';

class PreferenceRepository {
  static var dbObject;

  static init() {
    dbObject = PreferenceMethods();
    dbObject.init();
  }

  static addPreferences(PreferenceEntry preferenceEntry) =>
      dbObject.addPreferences(preferenceEntry);

  static deletePreferences(String preferenceEntry) =>
      dbObject.deletePreferences(preferenceEntry);

  static getPreferences(String preferenceId) =>
      dbObject.getPreferences(preferenceId);

  static close() => dbObject.close();
}
