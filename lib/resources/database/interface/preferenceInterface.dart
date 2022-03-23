import 'package:tumble/models/userPreferenceModel.dart';

abstract class PreferenceInterface {
  init();

  addPreferences(PreferenceEntry preferenceEntry);

  Future<PreferenceEntry?> getPreferences(String preferenceId);

  deletePreferences(String preferenceId);

  close();
}
