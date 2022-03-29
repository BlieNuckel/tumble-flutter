import 'package:flutter/material.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';

class ViewProvider with ChangeNotifier {
  static Future<String?> init() async {
    PreferenceDTO preferenceDTO =
        (await PreferenceRepository.getPreferences())!;
    return preferenceDTO.theme;
  }
}
