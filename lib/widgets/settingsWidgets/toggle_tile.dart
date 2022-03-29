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
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SwitchListTile(
                title: Text(
                  "Dark Mode",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                  ),
                ),
                value: _toggleValue,
                onChanged: (value) {
                  widget.onToggle(value);
                  setState(() {
                    _toggleValue = !_toggleValue;
                  });
                },
                secondary: Icon(widget.prefixIcon),
                visualDensity: VisualDensity.compact,
                activeColor: Theme.of(context).colorScheme.primaryContainer,
                activeTrackColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
