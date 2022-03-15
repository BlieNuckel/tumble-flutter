import 'package:flutter/material.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/models/dayDivider.dart';
import 'package:tumble/pages/scheduleViews/eventDetails.dart';
import 'package:tumble/pages/selectorViews/search.dart';
import 'package:tumble/widgets/appwideWidgets/customTopBar.dart';
import 'package:tumble/widgets/scheduleViewWidgets/daydivider.dart';
import 'package:tumble/widgets/appwideWidgets/loadingCircle.dart';
import 'package:tumble/widgets/scheduleViewWidgets/schedulecard.dart';
import 'package:tumble/widgets/scheduleViewWidgets/toTopBtn.dart';

import '/models/schedule.dart';

class SchedulePage extends StatefulWidget {
  final String currentScheduleId;

  const SchedulePage({Key? key, required this.currentScheduleId})
      : super(key: key);

  @override
  _SchedulePage createState() => _SchedulePage();
}

class _SchedulePage extends State<SchedulePage> {
  final GlobalKey<CustomTopBarState> _keyTopBar = GlobalKey();
  final GlobalKey<ToTopButtonState> _keyToTopBtn = GlobalKey();

  // Variable that contains a list of DayDivider and Schedule objects
  late List<Object> _schedules;
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
  bool _isLoading = true;

  void scrollToTopCB() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut);
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      _keyTopBar.currentState!
          .updateVisibility(_scrollController.position.pixels);
      _keyToTopBtn.currentState!
          .updateVisibility(_scrollController.position.pixels);
    });

    getSchedules();
    super.initState();
  }

  Future<List<Object>> getSchedules() async {
    // .getSchedule returns a list of DayDivider and Schedule objects
    _schedules = (await ScheduleApi.getSchedule(
        widget.currentScheduleId, context, false));
    setState(() {
      _isLoading = false;
    });
    return _schedules;
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
              ListView.builder(
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
                      end: scheduleVar.end,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventDetailsPage(
                                      event: scheduleVar,
                                    )));
                      },
                    );
                  } else if (scheduleVar is DayDivider) {
                    return DayDividerWidget(
                        dayName: scheduleVar.dayName,
                        date: scheduleVar.date,
                        firstDayDivider: index == 0);
                  } else {
                    return Container();
                  }
                },
              ),
              ToTopButton(
                key: _keyToTopBtn,
                scrollToTopCB: scrollToTopCB,
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
