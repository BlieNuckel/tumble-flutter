import 'package:flutter/material.dart';
import 'package:tumble/models/scheduleAPI.dart';
import 'package:tumble/models/scheduleList/dayDivider.dart';
import 'package:tumble/views/widgets/customTopBar.dart';
import 'package:tumble/views/widgets/daydivider.dart';
import 'package:tumble/views/widgets/schedulecard.dart';

import '../models/scheduleList/schedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  final GlobalKey<CustomTopBarState> _key = GlobalKey();

  // Variable that contains a list of DayDivider and Schedule objects
  late List<Object> _schedules;
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
  bool _isLoading = true;

  @override
  void initState() {
    _scrollController.addListener(() {
      _key.currentState!.updateVisibility(_scrollController.position.pixels);
    });

    super.initState();
  }

  Future<List<Object>> getSchedules() async {
    // .getSchedule returns a list of DayDivider and Schedule objects
    setState(() {
      _isLoading = false;
    });
    _schedules = await ScheduleApi.getSchedule("p.TBSE2+2021+35+100+NML+en");
    return _schedules;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
            // decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 4))),
            color: Theme.of(context).colorScheme.background,
            child: Stack(children: [
              FutureBuilder(
                future: getSchedules(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      controller: _scrollController,
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
                              color: scheduleVar.color,
                              start: scheduleVar.start,
                              end: scheduleVar.end);
                        } else if (scheduleVar is DayDivider) {
                          return DayDividerWidget(
                              dayName: scheduleVar.dayName, date: scheduleVar.date, firstDayDivider: index == 0);
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                  return Container();
                },
              ),
              CustomTopBar(
                key: _key,
              )
            ])));
  }
}
