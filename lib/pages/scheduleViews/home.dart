import 'package:flutter/material.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/pages/scheduleViews/schedulePage.dart';
import 'package:tumble/pages/scheduleViews/weekPage.dart';

import '../../service_locator.dart';

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
    Map<String, int> _pagesMap = {'schedule': 0, 'week': 1};

    _pages = [_schedulePage, _weekPage];

    _currentIndex = _pagesMap[locator<PreferenceDTO>().viewType]!;
    _currentPage = _pages[_pagesMap[locator<PreferenceDTO>().viewType]!];

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
