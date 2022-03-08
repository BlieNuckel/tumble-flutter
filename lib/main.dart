import 'package:flutter/material.dart';
import 'package:tumble/views/home.dart';

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
          fontFamily: 'Roboto',
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          textTheme:
              const TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: const HomePage(),
    );
  }
}
