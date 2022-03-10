import 'package:flutter/material.dart';
import 'package:tumble/views/widgets/scheduleSearchBar.dart';

class ScheduleSearchPage extends StatefulWidget {
  const ScheduleSearchPage({Key? key}) : super(key: key);

  @override
  State<ScheduleSearchPage> createState() => _ScheduleSearchPageState();
}

class _ScheduleSearchPageState extends State<ScheduleSearchPage> {
  final GlobalKey<_SlideableLogoImageState> _key = GlobalKey();

  FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => {_key.currentState!.focusChanged()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 30),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideableLogoImage(
              key: _key,
            ),
            ScheduleSearchBar(focus: _focus),
          ],
        ),
      ),
    );
  }
}

class SlideableLogoImage extends StatefulWidget {
  const SlideableLogoImage({Key? key}) : super(key: key);

  @override
  State<SlideableLogoImage> createState() => _SlideableLogoImageState();
}

class _SlideableLogoImageState extends State<SlideableLogoImage> {
  bool _visible = true;

  focusChanged() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 150),
          child: SizedOverflowBox(
            size: Size(double.infinity, (_visible ? 300 : 0)),
            child: const Image(height: 250, image: AssetImage("assets/images/tumbleAppLogo.png")),
          ),
        ));
  }
}
