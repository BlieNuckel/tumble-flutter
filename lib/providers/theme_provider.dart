import 'package:flutter/material.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';

import '../service_locator.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = locator<PreferenceDTO>().theme == "dark"
      ? ThemeMode.dark
      : ThemeMode.system;

  ThemeMode get mode => themeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    locator<PreferenceDTO>().theme = isOn ? "dark" : "null";
    themeMode = locator<PreferenceDTO>().theme == "dark"
        ? ThemeMode.dark
        : ThemeMode.system;
    notifyListeners();
  }
}
