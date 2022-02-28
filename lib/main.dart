

import 'package:flutter/material.dart';
import 'package:tumble/views/home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tumble',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Colors.white
          )
        ) 
      ),
      home: HomePage(),
    );
  }
  
}