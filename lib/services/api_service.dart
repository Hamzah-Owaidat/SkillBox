import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://192.168.0.108/skillbox/public"; // change if needed

  static Future<Map<String, dynamic>> register(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print('Server response body: ${response.body}'); // optional debug

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> login(Map<String, String> data) async {
    final response = await http.post(Uri.parse("$baseUrl/login"), body: data);

    return jsonDecode(response.body);
  }
}
