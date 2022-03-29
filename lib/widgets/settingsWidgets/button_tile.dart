import 'package:flutter/material.dart';

class ButtonSettingsTile extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final String subtitle;
  final Function onPressed;

  const ButtonSettingsTile(
      {Key? key, required this.prefixIcon, required this.title, required this.subtitle, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => onPressed(),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Icon(prefixIcon),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w200,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
