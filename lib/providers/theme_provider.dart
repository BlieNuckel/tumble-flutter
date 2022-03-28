import 'package:flutter/material.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider(this.themeMode);

  static Future<ThemeProvider> init() async {
    PreferenceDTO preferences = (await PreferenceRepository.getPreferences())!;
    return preferences.theme == "dark" ? ThemeProvider(ThemeMode.dark) : ThemeProvider(ThemeMode.system);
  }

  ThemeMode themeMode;

  ThemeMode get mode => themeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) async {
    await PreferenceRepository.updatePreferences(isOn ? PreferenceDTO(theme: "dark") : PreferenceDTO(theme: "null"));
    PreferenceDTO preferences = (await PreferenceRepository.getPreferences())!;
    themeMode = preferences.theme == "dark" ? ThemeMode.dark : ThemeMode.system;

    notifyListeners();
  }
}
