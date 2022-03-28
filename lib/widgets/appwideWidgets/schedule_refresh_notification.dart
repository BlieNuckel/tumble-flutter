import 'package:flutter/material.dart';

class ScheduleRefreshNotification extends StatefulWidget {
  const ScheduleRefreshNotification({Key? key, required this.showScheduleUpdateNotCB, required this.onClick})
      : super(key: key);

  final Function showScheduleUpdateNotCB;
  final Function onClick;

  @override
  State<ScheduleRefreshNotification> createState() => _ScheduleRefreshNotificationState();
}

class _ScheduleRefreshNotificationState extends State<ScheduleRefreshNotification> {
  double _iconRotation = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      splashColor: Colors.white30,
      color: Colors.greenAccent.shade400,
      elevation: 0,
      highlightElevation: 0,
      onPressed: () {
        setState(() {
          _iconRotation++;
        });
        widget.onClick();
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "New schedule found, click to update",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AnimatedRotation(
                  curve: Curves.decelerate,
                  turns: _iconRotation,
                  duration: const Duration(milliseconds: 500),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
