import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BackendProvider {
  static Future<Response> getFullSchedule(String scheduleId) async {
    var uri = Uri.https('kronox-app-backend.herokuapp.com', '/schedules/' + scheduleId);

    return await http.get(uri);
  }

  static Future<Response> getSearchResults(String searchQuery) async {
    var uri = Uri.https('kronox-app-backend.herokuapp.com', '/schedules/search/', {'search': searchQuery});

    return await http.get(uri);
  }
}
