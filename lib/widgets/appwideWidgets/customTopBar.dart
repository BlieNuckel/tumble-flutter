import 'package:flutter/material.dart';
import 'package:tumble/pages/utilViews/search_settings_page.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/resources/database/repository/scheduleRepository.dart';
import 'package:tumble/pages/selectorViews/search.dart';
import 'package:tumble/pages/utilViews/settingsPage.dart';

class CustomTopBar extends StatefulWidget {
  final String? currentScheduleId;
  final bool showSearchButton;
  final bool searchMenuSettings;

  const CustomTopBar(
      {Key? key,
      this.currentScheduleId,
      this.showSearchButton = true,
      this.searchMenuSettings = false})
      : super(key: key);

  @override
  State<CustomTopBar> createState() => CustomTopBarState();
}

class CustomTopBarState extends State<CustomTopBar> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 150),
        child: Container(
            height: MediaQuery.of(context).viewPadding.top + 50,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            alignment: Alignment.bottomLeft,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                () {
                  if (widget.currentScheduleId == null) return Container();
                  return FavoriteButton(
                      currentScheduleId: widget.currentScheduleId!);
                }(),
                Row(
                  children: [
                    () {
                      if (!widget.showSearchButton) return Container();
                      return Material(
                          color: Colors.transparent,
                          child: IconButton(
                              icon: const Icon(Icons.search),
                              iconSize: 32,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScheduleSearchPage()));
                              },
                              splashRadius: 20,
                              enableFeedback: true,
                              color:
                                  Theme.of(context).colorScheme.onBackground));
                    }(),
                    Material(
                        color: Colors.transparent,
                        child: IconButton(
                            icon: const Icon(Icons.settings_outlined),
                            iconSize: 32,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          widget.searchMenuSettings
                                              ? SearchSettingsPage()
                                              : SettingsPage(
                                                  currentScheduleId:
                                                      widget.currentScheduleId!,
                                                ))));
                            },
                            splashRadius: 20,
                            enableFeedback: true,
                            color: Theme.of(context).colorScheme.onBackground))
                  ],
                )
              ],
            )));
  }

  updateVisibility(double scrollPixels) {
    setState(() {
      if (scrollPixels > 35) {
        _visible = false;
      } else {
        _visible = true;
      }
    });
  }
}

class FavoriteButton extends StatefulWidget {
  final String currentScheduleId;

  const FavoriteButton({Key? key, required this.currentScheduleId})
      : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _favorited;
  late Future<bool> _future;

  Future<bool> initFavorited() async {
    _favorited = await ScheduleApi.isFavorite(widget.currentScheduleId);
    return _favorited;
  }

  @override
  void initState() {
    _future = initFavorited();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: FutureBuilder(
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return IconButton(
                  icon: _favorited
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_outline),
                  iconSize: 30,
                  onPressed: () async {
                    setState(() {
                      _favorited = !_favorited;
                    });
                    if (await ScheduleApi.isFavorite(
                        widget.currentScheduleId)) {
                      await ScheduleRepository.deleteSchedules(
                          widget.currentScheduleId);
                    } else {
                      await ScheduleApi.saveCurrScheduleToDb(
                          widget.currentScheduleId);
                    }
                  },
                  splashRadius: 20,
                  enableFeedback: true,
                  color: _favorited
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onBackground);
            }

            return Container();
          }),
          future: _future,
        ));
  }
}
