import 'package:flutter/material.dart';
import 'package:tumble/models/school.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';
import 'package:tumble/views/widgets/schoolCard.dart';

class SchoolSelectionPage extends StatelessWidget {
  SchoolSelectionPage({Key? key}) : super(key: key);
  final List<School?> _schoolList = [null];

  @override
  Widget build(BuildContext context) {
    _schoolList.addAll(SchoolSelectorProvider.schools);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.background,
        child: ListView.builder(
          itemCount: _schoolList.length,
          itemBuilder: ((context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Text(
                  "Choose your school",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 26,
                  ),
                ),
              );
            }

            final schoolObj = _schoolList[index] as School;
            return SchoolCard(
              schoolName: schoolObj.schoolName,
              schoolId: schoolObj.schoolId,
              schoolLogo: schoolObj.schoolLogo,
            );
          }),
        ),
      ),
    );
  }
}
