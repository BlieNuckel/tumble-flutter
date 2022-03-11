import 'package:flutter/material.dart';

class ToTopButton extends StatefulWidget {
  final Function scrollToTopCB;

  const ToTopButton({Key? key, required this.scrollToTopCB}) : super(key: key);

  @override
  State<ToTopButton> createState() => ToTopButtonState();
}

class ToTopButtonState extends State<ToTopButton> {
  bool _visible = false;

  updateVisibility(double pixelPos) {
    setState(() {
      if (pixelPos > 800) {
        _visible = true;
      } else {
        _visible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: 100,
      right: _visible ? 30 : -60,
      duration: const Duration(milliseconds: 200),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))],
        ),
        child: MaterialButton(
            onPressed: () => widget.scrollToTopCB(),
            visualDensity: VisualDensity.compact,
            splashColor: Colors.grey.shade200,
            child: Column(
              children: [
                Icon(
                  Icons.keyboard_arrow_up_sharp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                Text(
                  'TOP',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                )
              ],
            )),
      ),
    );
  }
}
