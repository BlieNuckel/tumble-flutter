import 'package:flutter/material.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';
import 'package:tumble/pages/selectorViews/schoolSelectionPage.dart';
import 'package:tumble/widgets/settingsWidgets/settingsSection.dart';
import 'package:tumble/widgets/settingsWidgets/settingsTiles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 40,
          ),
          SettingsSection(
            title: "Common",
            tiles: [
              ButtonSettingsTile(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SchoolSelectionPage())));
                },
                title: "Change school",
                subtitle: "Current school is " +
                    SchoolSelectorProvider.getDefaultSchool()!.name,
                prefixIcon: Icons.swap_horizontal_circle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
