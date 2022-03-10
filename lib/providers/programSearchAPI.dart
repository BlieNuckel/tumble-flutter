import 'dart:convert';

import 'package:tumble/models/programme.dart';
import 'package:tumble/providers/backendProvider.dart';

class ProgramSearchAPI {
  static Future<List<Program>> getProgramList(String searchQuery) async {
    final response = await BackendProvider.getSearchResults(searchQuery);

    if (response.statusCode == 200) {
      Map data = jsonDecode(utf8.decode(response.bodyBytes));

      List programs = data['requestedSchedule'];

      return _scheduleFromSnapshot(programs);
    }

    return _scheduleFromSnapshot([]);
  }

  static List<Program> _scheduleFromSnapshot(List list) {
    return list.map((data) {
      return Program.fromJson(data);
    }).toList();
  }
}
