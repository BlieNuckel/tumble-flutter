import 'package:flutter/material.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/views/widgets/customTopBar.dart';
import 'package:tumble/views/widgets/loadingCircle.dart';

class WeekPage extends StatefulWidget {
  final String currentScheduleId;

  const WeekPage({Key? key, required this.currentScheduleId}) : super(key: key);

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  final GlobalKey<CustomTopBarState> _keyTopBar = GlobalKey();

  late List<Object> _schedules_for_db;
  late List<Object> _schedules;
  bool _isLoading = true;

  @override
  void initState() {
    getSchedules();

    super.initState();
  }

  Future<void> getSchedules() async {
    // .getSchedule returns a list of DayDivider and Schedule objects
    _schedules =
        await ScheduleApi.getWeekSplitSchedule(widget.currentScheduleId);
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
              Container(),
              CustomTopBar(
                key: _keyTopBar,
                currentScheduleId: widget.currentScheduleId,
                schedules: _schedules_for_db,
              )
            ];
          }
        }(),
      ),
    );
  }
}
