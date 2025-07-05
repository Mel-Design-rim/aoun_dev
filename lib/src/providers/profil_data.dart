import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileData {
  static const String baseUrl = 'YOUR_BACKEND_URL';

  static Future<Map<String, dynamic>> getProfileData(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/profile/$userId'),
        headers: {
          'Content-Type': 'application/json',
          // Add any required authentication headers here
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load profile data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching profile data: $e');
    }
  }

  static Future<bool> updateProfileData(String userId, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/profile/$userId'),
        headers: {
          'Content-Type': 'application/json',
          // Add any required authentication headers here
        },
        body: json.encode(data),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error updating profile data: $e');
    }
  }
}
