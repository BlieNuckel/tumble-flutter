import 'package:tumble/models/user_preference_dto.dart';

abstract class PreferenceInterface {
  init();

  addPreferences(PreferenceDTO preferenceEntry);

  Future<PreferenceDTO?> getPreferences();

  deletePreferences(String preferenceId);

  updatePreferences(PreferenceDTO newPreferenceDTO);

  close();
}
