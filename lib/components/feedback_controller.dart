import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FeedbackController{
  static Future<bool> send(String msg, double rating) async {
    print(msg.length);
    if(msg.length < 5) return false;
    final Map<String, dynamic> data = {
      '"msg"' : '"' + msg + '"',
      '"rating"' : rating
    };
    final response = await http.put(Uri.https('kios-q-default-rtdb.firebaseio.com','feedback/${DateTime.now().millisecondsSinceEpoch}.json'), body: data.toString());
    print(data.toString() + '\n' + response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<FeedbackObject>> get() async{
    final response = await http.get(Uri.https('kios-q-default-rtdb.firebaseio.com','feedback.json'));
    if (response.statusCode != 200) return null;
    Map value = jsonDecode(response.body) as Map;
    List<FeedbackObject> obj = [];
    value.forEach((key, value) => obj.add(FeedbackObject.fromJson(value, int.parse(key))));
    return obj;
  }
}

class FeedbackObject{
  DateTime date;
  final String msg;
  final double rating;
  FeedbackObject({this.msg, this.rating, DateTime inputdate}){
    if(inputdate == null) date = DateTime.now();
    else date = inputdate;
  }
  factory FeedbackObject.fromJson(Map<String, dynamic> data, int epochdate) {
    return FeedbackObject(
      msg: data['msg'] as String,
      rating: data['rating'] as double,
      inputdate: DateTime.fromMillisecondsSinceEpoch(epochdate),
    );
  }
}