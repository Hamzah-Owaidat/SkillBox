import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static String get baseUrl {
    // Try to get from environment variable, fallback to default
    final envUrl = dotenv.env['API_BASE_URL'];
    if (envUrl != null && envUrl.isNotEmpty) {
      return envUrl;
    }
    // Default fallback
    return "http://192.168.0.108/skillbox/public";
  }

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

  static Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String fullName,
    required String email,
    String? oldPassword,
    String? newPassword,
  }) async {
    final Map<String, dynamic> body = {
      'full_name': fullName,
      'email': email,
    };

    if (newPassword != null && newPassword.isNotEmpty) {
      if (oldPassword == null || oldPassword.isEmpty) {
        return {'error': 'Old password is required to change password'};
      }
      body['old_password'] = oldPassword;
      body['new_password'] = newPassword;
    }

    final response = await http.put(
      Uri.parse("$baseUrl/api/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    try {
      final decoded = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return {
          'success': false,
          'error': decoded['error'] ?? 'Failed to update profile'
        };
      }
      return decoded;
    } catch (e) {
      return {'success': false, 'error': 'Invalid server response'};
    }
  }

  static Future<Map<String, dynamic>> sendResetCode(String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/forgot-password"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    try {
      final decoded = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return {
          'success': false,
          'error': decoded['error'] ?? 'Failed to send reset code',
          'errors': decoded['errors'],
        };
      }
      return decoded;
    } catch (e) {
      return {'success': false, 'error': 'Invalid server response'};
    }
  }

  static Future<Map<String, dynamic>> verifyResetCode({
    required String code,
    required int userId,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/verify-reset-code"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'code': code,
        'user_id': userId,
      }),
    );

    try {
      final decoded = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return {
          'success': false,
          'error': decoded['error'] ?? 'Failed to verify code',
          'errors': decoded['errors'],
        };
      }
      return decoded;
    } catch (e) {
      return {'success': false, 'error': 'Invalid server response'};
    }
  }

  static Future<Map<String, dynamic>> resetPassword({
    required String code,
    required int userId,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/reset-password"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'code': code,
        'user_id': userId,
        'password': password,
        'confirm_password': confirmPassword,
      }),
    );

    try {
      final decoded = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return {
          'success': false,
          'error': decoded['error'] ?? 'Failed to reset password',
          'errors': decoded['errors'],
        };
      }
      return decoded;
    } catch (e) {
      return {'success': false, 'error': 'Invalid server response'};
    }
  }
}
