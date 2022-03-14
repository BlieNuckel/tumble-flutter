import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tumble/views/schedulePage.dart';
import 'package:tumble/views/weekPage.dart';

class HomePage extends StatefulWidget {
  final String currentScheduleId;

  const HomePage({Key? key, required this.currentScheduleId}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  late List<Widget> _pages;
  late Widget _schedulePage;
  late Widget _weekPage;

  late int _currentIndex;
  late Widget _currentPage;

  @override
  void initState() {
    _schedulePage = SchedulePage(
      currentScheduleId: widget.currentScheduleId,
    );
    _weekPage = WeekPage(currentScheduleId: widget.currentScheduleId);

    _pages = [_schedulePage, _weekPage];
    _currentIndex = 0;
    _currentPage = _schedulePage;

    super.initState();
  }

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => changePage(index),
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 40,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_view_day_rounded), label: "Schedule"),
          BottomNavigationBarItem(icon: Icon(Icons.view_week_rounded), label: "Week"),
        ],
      ),
    );
  }
}
