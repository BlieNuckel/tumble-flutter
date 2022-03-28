import 'package:flutter/material.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';
import 'package:tumble/pages/selectorViews/schoolSelectionPage.dart';
import 'package:tumble/providers/theme_provider.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';
import 'package:tumble/service_locator.dart';
import 'package:tumble/widgets/settingsWidgets/settingsSection.dart';
import 'package:tumble/widgets/settingsWidgets/button_tile.dart';
import 'package:tumble/widgets/settingsWidgets/toggle_tile.dart';

import '../../util/school_enum.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  late SchoolEnum _defaultSchool;

  Future<SchoolEnum> setupAsnycVars() async {
    _defaultSchool = (await SchoolSelectorProvider.getDefaultSchool())!;
    return _defaultSchool;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
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
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => SchoolSelectionPage())));
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
                  ],
                ),
              ],
            );
          }
          return Container();
        }),
        future: setupAsnycVars(),
      ),
    );
  }
}
