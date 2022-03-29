import 'package:flutter/material.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';
import 'package:tumble/pages/selectorViews/schoolSelectionPage.dart';
import 'package:tumble/providers/theme_provider.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';
import 'package:tumble/service_locator.dart';
import 'package:tumble/widgets/settingsWidgets/settingsSection.dart';
import 'package:tumble/widgets/settingsWidgets/button_tile.dart';
import 'package:flutter/material.dart';
import 'package:tumble/widgets/settingsWidgets/toggle_tile.dart';

import '../../util/school_enum.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final SchoolEnum _defaultSchool =
      (SchoolSelectorProvider.getDefaultSchool())!;

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
          SettingsSection(title: "Common", tiles: [
            ButtonSettingsTile(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => SchoolSelectionPage())));
              },
              title: "Change school",
              subtitle: "Current school is " + _defaultSchool.name,
              prefixIcon: Icons.swap_horizontal_circle,
            ),
            ToggleSettingsTile(
              onToggle: locator<ThemeProvider>().toggleTheme,
              toggleValue: locator<ThemeProvider>().isDarkMode,
              title: "Dark Mode",
              prefixIcon: Icons.dark_mode_outlined,
            ),

            /// Tile that opens bottom sheet modal, allows users to choose
            /// between their default viewtype. Depending on which option
            /// you press the appropriate database change will occur.
            ButtonSettingsTile(
                prefixIcon: Icons.view_day_rounded,
                title: 'Set default schedule view',
                subtitle: "Current view: ${locator<PreferenceDTO>().viewType}",
                onPressed: () => showModalBottomSheet(
                    constraints: const BoxConstraints(maxHeight: 150),
                    context: context,
                    builder: (context) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                              leading: const Icon(Icons.view_day_rounded),
                              title: const Text('Default view'),
                              onTap: () => locator<PreferenceDTO>().viewType =
                                  'default'),
                          ListTile(
                              leading: const Icon(Icons.view_week_rounded),
                              title: const Text('Week view'),
                              onTap: () =>
                                  locator<PreferenceDTO>().viewType = 'week')
                        ],
                      );
                    }))
          ])
        ],
      ),
    );
  }
}
