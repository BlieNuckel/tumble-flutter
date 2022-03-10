import 'package:flutter/material.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/views/search.dart';

class CustomTopBar extends StatefulWidget {
  final String currentScheduleId;

  const CustomTopBar({Key? key, required this.currentScheduleId}) : super(key: key);

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
                Row(
                  children: [
                    FavoriteButton(
                      currentScheduleId: widget.currentScheduleId,
                    )
                  ],
                ),
                Row(
                  children: [
                    Material(
                        color: Colors.transparent,
                        child: IconButton(
                            icon: const Icon(Icons.search),
                            iconSize: 32,
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const ScheduleSearchPage()));
                            },
                            splashRadius: 20,
                            enableFeedback: true,
                            color: Theme.of(context).colorScheme.onBackground)),
                    Material(
                        color: Colors.transparent,
                        child: IconButton(
                            icon: const Icon(Icons.settings_outlined),
                            iconSize: 32,
                            onPressed: () {},
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

  const FavoriteButton({Key? key, required this.currentScheduleId}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _favorited;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _favorited = ScheduleApi.isFavorite(widget.currentScheduleId);
    });
    return Material(
        color: Colors.transparent,
        child: IconButton(
            icon: _favorited ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
            iconSize: 30,
            onPressed: () {
              if (ScheduleApi.isFavorite(widget.currentScheduleId)) {
                ScheduleApi.setFavorite('');
              } else {
                ScheduleApi.setFavorite(widget.currentScheduleId);
              }

              setState(() {
                _favorited = ScheduleApi.isFavorite(widget.currentScheduleId);
              });
            },
            splashRadius: 20,
            enableFeedback: true,
            color: _favorited ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onBackground));
  }
}
