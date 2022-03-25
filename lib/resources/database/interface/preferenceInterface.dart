import 'package:tumble/models/user_preference_dto.dart';

abstract class PreferenceInterface {
  addPreferences(PreferenceDTO preferenceEntry);

  Future<PreferenceDTO?> getPreferences();

  deletePreferences(String preferenceId);

  updatePreferences(PreferenceDTO newPreferenceDTO);

  close();
}
