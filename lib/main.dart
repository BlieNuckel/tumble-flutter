import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tumble/models/scheduleAPI.dart';
import 'package:tumble/providers/localStorage.dart';
import 'package:tumble/service_locator.dart';
import 'package:tumble/views/home.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/views/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tumble',
      theme: ThemeData(
        colorScheme: CustomColors.lightColors,
        fontFamily: 'Roboto',
      ),
      home: ScheduleApi.hasFavorite()
          ? HomePage(
              currentScheduleId: locator<LocalStorageService>().getScheduleFavorite(),
            )
          : ScheduleSearchPage(),
    );
  }
}
