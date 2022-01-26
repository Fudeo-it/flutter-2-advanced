import 'package:http/http.dart' as http;
import 'dart:convert';

class QuotesRepository {
  static Future<String> get() async {
    final response = await http.get(Uri.parse("https://programming-quotes-api.herokuapp.com/quotes/random"));
    final jsonData = json.decode(response.body);
    return jsonData["en"];
  }
}
