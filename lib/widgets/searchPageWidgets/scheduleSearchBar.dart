import 'package:flutter/material.dart';

class ScheduleSearchBar extends StatefulWidget {
  final focus;
  final Function(String) loadSchedulesCB;

  const ScheduleSearchBar({Key? key, required this.focus, required this.loadSchedulesCB}) : super(key: key);

  @override
  State<ScheduleSearchBar> createState() => _ScheduleSearchBarState();
}

class _ScheduleSearchBarState extends State<ScheduleSearchBar> {
  final _textFieldController = TextEditingController();
  bool _textInField = false;

  @override
  void initState() {
    _textFieldController.addListener(() {
      setState(() {
        _textInField = _textFieldController.value.text != "";
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))],
          ),
          child: TextField(
              focusNode: widget.focus,
              controller: _textFieldController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (!_textInField) return;

                widget.loadSchedulesCB(_textFieldController.value.text);
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search schedules",
                hintMaxLines: 1,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                suffixIcon: AnimatedOpacity(
                    opacity: _textInField ? 1 : 0,
                    duration: const Duration(milliseconds: 150),
                    child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          color: Theme.of(context).colorScheme.onSurface,
                          onPressed: () => {_textFieldController.text = ""},
                          icon: const Icon(Icons.close),
                          iconSize: 20,
                          splashRadius: 12,
                        ))),
              )),
        )),
        Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))],
          ),
          child: MaterialButton(
            onPressed: () {
              if (!_textInField) return;

              widget.loadSchedulesCB(_textFieldController.value.text);
              FocusManager.instance.primaryFocus?.unfocus();
            },
            visualDensity: VisualDensity.compact,
            splashColor: Colors.white.withOpacity(0.4),
            child: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
