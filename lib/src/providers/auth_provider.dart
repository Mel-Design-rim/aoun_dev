import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';

class AuthProvider {
  // Keys for SharedPreferences
  static const String _tokenKey = 'auth_token';
  static const String _userTypeKey = 'user_type'; // 'user' or 'association'
  static const String _userIdKey = 'user_id';

  // Login user
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.login}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        
        // Save authentication data
        await _saveAuthData(
          token: responseData['token'],
          userType: 'user',
          userId: responseData['user']['id'].toString(),
        );
        
        return {'success': true, 'user': responseData['user']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Login failed';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error during login: $e'};
    }
  }

  // Login association
  static Future<Map<String, dynamic>> loginAssociation(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.associations}/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        
        // Save authentication data
        await _saveAuthData(
          token: responseData['token'],
          userType: 'association',
          userId: responseData['association']['id'].toString(),
        );
        
        return {'success': true, 'association': responseData['association']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Login failed';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error during login: $e'};
    }
  }

  // Save authentication data to SharedPreferences
  static Future<void> _saveAuthData({required String token, required String userType, required String userId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userTypeKey, userType);
    await prefs.setString(_userIdKey, userId);
  }

  // Get token from SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get user type from SharedPreferences
  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  // Get user ID from SharedPreferences
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userTypeKey);
    await prefs.remove(_userIdKey);
  }

  // Get authorization headers for API requests
  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}