import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tumble/providers/schoolSelectorProvider.dart';

class BackendProvider {
  static Future<Response> getFullSchedule(String scheduleId) async {
    var uri = Uri.https('kronox-app-backend.herokuapp.com', '/schedules/' + scheduleId,
        {'school': SchoolSelectorProvider.getDefaultSchool()!.name});
    // var uri = Uri.https('10.0.2.2:8000', '/schedules/' + scheduleId, {'school': 'mau'});

    return await http.get(uri);
  }

  static Future<Response> getSearchResults(String searchQuery) async {
    var uri = Uri.https('kronox-app-backend.herokuapp.com', '/schedules/search/',
        {'search': searchQuery, 'school': SchoolSelectorProvider.getDefaultSchool()!.name});
    // Uri.https('10.0.2.2:8000', '/schedules/search/', {'search': searchQuery, 'school': 'mau'});

    return await http.get(uri);
  }
}
