import 'package:flutter/material.dart';
import 'package:tumble/models/scheduleAPI.dart';
import 'package:tumble/views/widgets/schedulecard.dart';

import '../models/schedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  late List<Schedule> _schedules;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getSchedules();
  }

  Future<void> getSchedules() async {
    _schedules = await ScheduleApi.getSchedule();
    setState(() {
      _isLoading = false;
    });

    print(_schedules);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('Tumble')],
      )),
      body: ScheduleCard(
        color: Color(0xFFFFFF),
        title: "Class",
        course: "Programming",
        lecturer: "Someone",
        location: "Somewhere",
      ),
    );
  }
}
