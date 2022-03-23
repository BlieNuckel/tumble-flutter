import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/resources/database/db/localStorageAPI.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';
import 'package:tumble/resources/database/repository/schedule_repository.dart';
import 'package:tumble/service_locator.dart';
import 'package:tumble/pages/scheduleViews/home.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/pages/selectorViews/schoolSelectionPage.dart';
import 'package:tumble/pages/selectorViews/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScheduleRepository.init();
  setup().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Brightness brighness = MediaQuery.platformBrightnessOf(context);
    bool isDarkMode = brighness == Brightness.dark;

    return MaterialApp(
        title: 'Tumble',
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
              statusBarIconBrightness:
                  isDarkMode ? Brightness.light : Brightness.dark),
          child: () {
            if (SchoolSelectorProvider.schoolSelected()) {
              if (ScheduleApi.hasFavorite()) {
                return HomePage(
                  currentScheduleId:
                      locator<LocalStorageService>().getScheduleFavorite(),
                );
              } else {
                return const ScheduleSearchPage();
              }
            } else {
              return SchoolSelectionPage();
            }
          }(),
        ));
  }
}
