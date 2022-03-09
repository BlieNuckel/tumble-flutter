import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tumble/views/home.dart';
import 'package:tumble/theme/colors.dart';

void main() {
  runApp(const MyApp());
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
      home: const HomePage(),
    );
  }
}
