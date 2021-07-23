import 'package:http/http.dart' as http;
class VideoParser {
  static Future<String> get() async {
    final response = await http
        .get(Uri.https('kios-q-default-rtdb.firebaseio.com', 'ytlink.json'));
    if (response.statusCode != 200) return null;
    print(response.body);
    return response.body.toString();
  }
}
