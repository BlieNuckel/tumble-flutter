import 'package:flutter/material.dart';
import 'package:tumble/models/scheduleAPI.dart';
import 'package:tumble/views/widgets/schedulecard.dart';

import '../models/scheduleList/schedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  late List<Object>
      _schedules; // Variable that contains a list of DayDivider and Schedule objects
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getSchedules();
  }

  Future<void> getSchedules() async {
    // .getSchedule returns a list of DayDivider and Schedule objects
    _schedules = await ScheduleApi.getSchedule("p.TBSE2+2021+35+100+NML+en");
    setState(() {
      _isLoading = false;
    });

    _schedules.forEach((element) {
      if (element is Schedule) {
        print(element.start);
      }
    });
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
