import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tumble/models/schedule_dto.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/resources/database/db/db_init.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';
import 'package:tumble/resources/database/repository/scheduleRepository.dart';
import 'package:tumble/pages/scheduleViews/home.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/pages/selectorViews/schoolSelectionPage.dart';
import 'package:tumble/pages/selectorViews/search.dart';
import 'package:tumble/widgets/appwideWidgets/loadingCircle.dart';

import 'models/user_preference_dto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbInit.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late List<ScheduleDTO> _allFavoriteSchedules;
  late bool _hasFavorite;
  late bool _schoolSelected;
  late bool _forceDarkMode;

  Future<List<ScheduleDTO>> setupAllSchedules() async {
    _allFavoriteSchedules = (await ScheduleRepository.getAllScheduleEntries())!;
    return _allFavoriteSchedules;
  }

  Future<bool> setupShoolSelected() async {
    _schoolSelected = await SchoolSelectorProvider.schoolSelected();
    return _schoolSelected;
  }

  Future<bool> setupHasFavorite() async {
    _hasFavorite = await ScheduleApi.hasFavorite();
    return _hasFavorite;
  }

  Future<bool> setupDarkMode() async {
    PreferenceDTO preferences = (await PreferenceRepository.getPreferences())!;
    _forceDarkMode = preferences.theme == "dark" ? true : false;
    return _forceDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.background,
          );
        }

        if (!_forceDarkMode) {
          final Brightness brighness = MediaQuery.platformBrightnessOf(context);
          _forceDarkMode = brighness == Brightness.dark;
        }

        return MaterialApp(
            title: 'Tumble',
            themeMode: ThemeMode.system,
            theme: ThemeData(
              colorScheme: CustomColors.lightColors,
              fontFamily: 'Roboto',
            ),
            darkTheme: ThemeData(
              colorScheme: CustomColors.darkColors,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: CustomColors.darkColors.primary,
              ),
              fontFamily: 'Roboto',
            ),
            home: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: _forceDarkMode ? Brightness.light : Brightness.dark),
                child: () {
                  if (_schoolSelected) {
                    if (_hasFavorite) {
                      return HomePage(
                        currentScheduleId: _allFavoriteSchedules[0].scheduleId,
                      );
                    }
                    return const ScheduleSearchPage();
                  }
                  return SchoolSelectionPage();
                }()));
      },
      future: Future.wait([
        setupAllSchedules(),
        setupHasFavorite(),
        setupShoolSelected(),
        setupDarkMode(),
      ]),
    );
  }
}
