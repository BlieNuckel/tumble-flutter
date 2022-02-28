import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
  
}

class _MainPageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
        Text('Tumble')
      ],)
      ),
    );
  }
}