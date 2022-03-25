import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tumble/models/schedule_dto.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/resources/database/db/db_init.dart';
import 'package:tumble/resources/database/db/localStorageAPI.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';
import 'package:tumble/resources/database/repository/scheduleRepository.dart';
import 'package:tumble/pages/scheduleViews/home.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/pages/selectorViews/schoolSelectionPage.dart';
import 'package:tumble/pages/selectorViews/search.dart';
import 'package:tumble/widgets/appwideWidgets/loadingCircle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbInit.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late List<ScheduleDTO> _allSchedules;
  late bool _hasFavorite;
  late bool _schoolSelected;

  Future<List<ScheduleDTO>> setupAllSchedules() async {
    _allSchedules = (await ScheduleRepository.getAllScheduleEntries())!;
    print("THIS IS SCHEDULES");
    return _allSchedules;
  }

  Future<bool> setupShoolSelected() async {
    _schoolSelected = await SchoolSelectorProvider.schoolSelected();
    print("THIS IS SCHOOL");
    return _schoolSelected;
  }

  Future<bool> setupHasFavorite() async {
    _hasFavorite = await ScheduleApi.hasFavorite();
    print("THIS IS FAVORITE");
    return _hasFavorite;
  }

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
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (_schoolSelected) {
                  if (_hasFavorite) {
                    return HomePage(
                      currentScheduleId:
                          //
                          _allSchedules[0].scheduleId,
                    );
                  }
                  return const ScheduleSearchPage();
                }
                return SchoolSelectionPage();
              }
              return const LoadCircle();
            },
            future: Future.wait([
              setupAllSchedules(),
              setupHasFavorite(),
              setupShoolSelected()
            ]),
          ),
        ));
  }
}
