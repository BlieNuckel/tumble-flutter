import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadCircle extends StatelessWidget {
  const LoadCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitPulse(
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
