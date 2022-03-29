import 'package:get_it/get_it.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/providers/theme_provider.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';

final GetIt locator = GetIt.instance;

Future<void> setup() async {
  locator.registerSingleton(await PreferenceRepository.getPreferences());
  locator.registerSingleton(ThemeProvider());
}
