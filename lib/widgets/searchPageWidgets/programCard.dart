import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  final String programName;
  final String programId;
  final Function onPush;

  const ProgramCard({Key? key, required this.programName, required this.programId, required this.onPush})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _programCode = programName.split(', ')[0];
    final String _programName = programName.split(', ')[1];

    return Container(
      color: Theme.of(context).colorScheme.background,
      width: double.infinity,
      height: 100,
      child: TextButton(
        onPressed: () => onPush(),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
          foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onBackground),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _programCode,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              ),
              Text(
                _programName,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
