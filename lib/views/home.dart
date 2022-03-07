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
  // Variable that contains a list of DayDivider and Schedule objects
  late List<Object> _schedules;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getSchedules() async {
    // .getSchedule returns a list of DayDivider and Schedule objects
    _schedules = await ScheduleApi.getSchedule("p.TBSE2+2021+35+100+NML+en");
    setState(() {
      _isLoading = false;
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
      body: FutureBuilder(
        future: getSchedules(),
        builder: (context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _schedules.length,
            itemBuilder: (context, index) {
              final scheduleVar = _schedules[index];
              if (scheduleVar is Schedule) {
                return ScheduleCard(
                    title: scheduleVar.title,
                    course: scheduleVar.course,
                    lecturer: scheduleVar.lecturer,
                    location: scheduleVar.location,
                    color: scheduleVar.color);
              }
              return ScheduleCard(
                  title: "empty",
                  course: "empty",
                  lecturer: "empty",
                  location: "empty",
                  color: "empty");
            },
          );
        },
      ),
    );
  }
}
