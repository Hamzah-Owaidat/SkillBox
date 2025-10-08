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
    final response = await http.post(
      Uri.parse("$baseUrl/api/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print('HTTP status: ${response.statusCode}');
    print('Server response body: ${response.body}');

    try {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      // If server returned an error message, include it
      if (response.statusCode != 200) {
        return {'error': decoded['error'] ?? 'Unknown server error'};
      }

      return decoded;
    } catch (e) {
      // JSON parsing failed
      return {'error': 'Invalid server response'};
    }
  }

  static Future<Map<String, dynamic>> getCurrentUser(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/me"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('getCurrentUser status: ${response.statusCode}');
    print('getCurrentUser body: ${response.body}');

    try {
      final decoded = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return {'error': decoded['error'] ?? 'Unknown error'};
      }
      return decoded;
    } catch (e) {
      return {'error': 'Invalid server response'};
    }
  }
}
