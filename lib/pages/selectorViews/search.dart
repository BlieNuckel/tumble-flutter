import 'package:flutter/material.dart';
import 'package:tumble/models/programme.dart';
import 'package:tumble/providers/programSearchAPI.dart';
import 'package:tumble/pages/scheduleViews/home.dart';
import 'package:tumble/widgets/appwideWidgets/loadingCircle.dart';
import 'package:tumble/widgets/searchPageWidgets/programCard.dart';
import 'package:tumble/widgets/searchPageWidgets/scheduleSearchBar.dart';
import 'package:tumble/widgets/searchPageWidgets/slideableLogo.dart';

class ScheduleSearchPage extends StatefulWidget {
  const ScheduleSearchPage({Key? key}) : super(key: key);

  @override
  State<ScheduleSearchPage> createState() => _ScheduleSearchPageState();
}

class _ScheduleSearchPageState extends State<ScheduleSearchPage> {
  final GlobalKey<SlideableLogoImageState> _key = GlobalKey();

  final FocusNode _focus = FocusNode();
  List<Program> _programList = [];
  bool _loading = false;
  bool _searched = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => {_key.currentState!.focusChanged()});
  }

  void loadScheduleCB(String searchQuery) async {
    setState(() {
      _loading = true;
      _searched = true;
    });
    List<Program> programsTemp =
        await ProgramSearchAPI.getProgramList(searchQuery);
    setState(() {
      _programList = programsTemp;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin:
            EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 30),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: SlideableLogoImage(
                key: _key,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              margin: const EdgeInsets.only(bottom: 10),
              child: ScheduleSearchBar(
                focus: _focus,
                loadSchedulesCB: loadScheduleCB,
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: () {
                  if (_loading) {
                    return const LoadCircle();
                  } else if (_programList.isEmpty && _searched) {
                    return Center(
                      child: Text(
                        "No schedules found",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _programList.length,
                      itemBuilder: ((context, index) {
                        final program = _programList[index];
                        if (index != _programList.length - 1) {
                          return Column(
                            children: [
                              ProgramCard(
                                  programName: program.programName,
                                  programId: program.programId,
                                  onPush: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                currentScheduleId:
                                                    program.programId)));
                                  }),
                              Divider(
                                indent: 20,
                                endIndent: 20,
                                height: 0,
                                thickness: 1,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            ],
                          );
                        }
                        return ProgramCard(
                            programName: program.programName,
                            programId: program.programId,
                            onPush: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                          currentScheduleId:
                                              program.programId)));
                            });
                      }),
                    );
                  }
                }(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
