import 'package:flutter/material.dart';

class ToggleSettingsTile extends StatefulWidget {
  final IconData prefixIcon;
  final String title;
  final Function(bool) onToggle;
  final bool toggleValue;

  const ToggleSettingsTile(
      {Key? key, required this.prefixIcon, required this.title, required this.onToggle, required this.toggleValue})
      : super(key: key);

  @override
  State<ToggleSettingsTile> createState() => _ToggleSettingsTileState();
}

class _ToggleSettingsTileState extends State<ToggleSettingsTile> {
  @override
  Widget build(BuildContext context) {
    bool _toggleValue = widget.toggleValue;

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
                  value: _toggleValue,
                  onChanged: (value) {
                    widget.onToggle(value);
                    setState(() {
                      _toggleValue = !_toggleValue;
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }
}
