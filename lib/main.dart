import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tumble/models/schedule_dto.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/providers/theme_provider.dart';
import 'package:tumble/resources/database/db/db_init.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';
import 'package:tumble/resources/database/repository/scheduleRepository.dart';
import 'package:tumble/pages/scheduleViews/home.dart';
import 'package:tumble/service_locator.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/pages/selectorViews/schoolSelectionPage.dart';
import 'package:tumble/pages/selectorViews/search.dart';

import 'models/user_preference_dto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbInit.init();
  await setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late List<ScheduleDTO> _allFavoriteSchedules;
  late bool _hasFavorite;
  final bool _schoolSelected = SchoolSelectorProvider.schoolSelected();

  Future<List<ScheduleDTO>> setupAllSchedules() async {
    _allFavoriteSchedules = (await ScheduleRepository.getAllScheduleEntries())!;
    return _allFavoriteSchedules;
  }

  Future<bool> setupHasFavorite() async {
    _hasFavorite = await ScheduleApi.hasFavorite();
    return _hasFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => locator<ThemeProvider>(),
        child: Consumer<ThemeProvider>(
          builder: (_, theme, __) {
            return MaterialApp(
              title: 'Tumble',
              themeMode: theme.mode,
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
                        Theme.of(context).brightness == Brightness.dark
                            ? Brightness.light
                            : Brightness.dark),
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    if (_schoolSelected) {
                      if (_hasFavorite) {
                        return HomePage(
                          currentScheduleId:
                              _allFavoriteSchedules[0].scheduleId,
                        );
                      }
                      return const ScheduleSearchPage();
                    }
                    return SchoolSelectionPage();
                  },
                  future: Future.wait([
                    setupAllSchedules(),
                    setupHasFavorite(),
                  ]),
                ),
              ),
            );
          },
        ));
  }
}
