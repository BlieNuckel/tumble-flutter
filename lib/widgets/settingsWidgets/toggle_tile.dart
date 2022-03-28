import 'package:flutter/material.dart';

class ToggleSettingsTile extends StatefulWidget {
  final IconData prefixIcon;
  final String title;
  final Function(bool) onToggle;

  const ToggleSettingsTile({Key? key, required this.prefixIcon, required this.title, required this.onToggle})
      : super(key: key);

  @override
  State<ToggleSettingsTile> createState() => _ToggleSettingsTileState();
}

class _ToggleSettingsTileState extends State<ToggleSettingsTile> {
  late bool _darkMode;

  @override
  Widget build(BuildContext context) {
    _darkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Icon(widget.prefixIcon),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Switch(
                  value: _darkMode,
                  onChanged: (value) {
                    widget.onToggle(value);
                    setState(() {
                      _darkMode = !_darkMode;
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }
}
