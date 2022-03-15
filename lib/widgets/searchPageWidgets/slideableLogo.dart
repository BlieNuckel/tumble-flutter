import 'package:flutter/material.dart';

class SlideableLogoImage extends StatefulWidget {
  const SlideableLogoImage({Key? key}) : super(key: key);

  @override
  State<SlideableLogoImage> createState() => SlideableLogoImageState();
}

class SlideableLogoImageState extends State<SlideableLogoImage> {
  bool _visible = true;

  focusChanged() {
    setState(() {
      _visible = false;
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
