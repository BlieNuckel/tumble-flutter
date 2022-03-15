import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';

class BackendProvider {
  static Future<Response> getFullSchedule(String scheduleId) async {
    var uri = Uri.https(
        'kronox-app-backend.herokuapp.com',
        '/schedules/' + scheduleId,
        {'school': SchoolSelectorProvider.getDefaultSchool()!.name});
    // var uri = Uri.https('10.0.2.2:8000', '/schedules/' + scheduleId, {'school': 'mau'});

    try {
      return await http.get(uri);
    } on SocketException {
      return http.Response("Failed to fetch", 502);
    }
  }

  static Future<Response> getSearchResults(String searchQuery) async {
    var uri = Uri.https(
        'kronox-app-backend.herokuapp.com', '/schedules/search/', {
      'search': searchQuery,
      'school': SchoolSelectorProvider.getDefaultSchool()!.name
    });
    // Uri.https('10.0.2.2:8000', '/schedules/search/', {'search': searchQuery, 'school': 'mau'});

    try {
      return await http.get(uri);
    } on SocketException {
      Fluttertoast.showToast(
          msg: "Failed to fetch search results",
          toastLength: Toast.LENGTH_LONG);

      return http.Response("Failed to fetch", 502);
    }
  }
}
