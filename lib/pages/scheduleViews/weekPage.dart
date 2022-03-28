import 'package:flutter/material.dart';
import 'package:tumble/models/week.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/widgets/appwideWidgets/customTopBar.dart';
import 'package:tumble/widgets/appwideWidgets/loadingCircle.dart';
import 'package:tumble/widgets/weekViewWidgets/weekWidget.dart';

class WeekPage extends StatefulWidget {
  final String currentScheduleId;

  const WeekPage({Key? key, required this.currentScheduleId}) : super(key: key);

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  final GlobalKey<CustomTopBarState> _keyTopBar = GlobalKey();

  // late List<Object> _schedules_for_db;
  late List<Week> _schedules;
  bool _isLoading = true;
  bool _showScheduleUpdateNot = false;

  void showScheduleUpdateNotCB() {
    setState(() {
      _showScheduleUpdateNot = true;
    });
  }

  @override
  void initState() {
    getSchedules();

    super.initState();
  }

  Future<void> getSchedules() async {
    // .getSchedule returns a list of DayDivider and Schedule objects
    _schedules =
        await ScheduleApi.getWeekSplitSchedule(widget.currentScheduleId, showNotificationCB: showScheduleUpdateNotCB);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Stack(
        children: () {
          if (_isLoading) {
            return const <Widget>[LoadCircle()];
          } else {
            return <Widget>[
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: _schedules.length,
                  itemBuilder: ((context, index) {
                    return WeekWidget(week: _schedules[index]);
                  }),
                ),
              ),
              CustomTopBar(
                key: _keyTopBar,
                currentScheduleId: widget.currentScheduleId,
              )
            ];
          }
        }(),
      ),
    );
  }
}
