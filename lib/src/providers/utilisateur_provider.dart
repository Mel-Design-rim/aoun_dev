import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'auth_provider.dart';

class UtilisateurProvider {
  // Create a new user
  static Future<Map<String, dynamic>> createUtilisateur(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.utilisateurs}'),
        headers: await AuthProvider.getAuthHeaders(),
        body: json.encode(userData),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to create user';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error creating user: $e'};
    }
  }

  // Login user
  static Future<Map<String, dynamic>> login(String email, String password) async {
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
        return {'success': true, 'user': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Login failed';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error during login: $e'};
    }
  }

  // Get all users
  static Future<Map<String, dynamic>> getAllUtilisateurs() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.utilisateurs}'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'users': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get users';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching users: $e'};
    }
  }

  // Update user
  static Future<Map<String, dynamic>> updateUtilisateur(int userId, Map<String, dynamic> userData) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.utilisateurs}/$userId'),
        headers: await AuthProvider.getAuthHeaders(),
        body: json.encode(userData),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to update user';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating user: $e'};
    }
  }

  // Delete user
  static Future<Map<String, dynamic>> deleteUtilisateur(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.utilisateurs}/$userId'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to delete user';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting user: $e'};
    }
  }
}