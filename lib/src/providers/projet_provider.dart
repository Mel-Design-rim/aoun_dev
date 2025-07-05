import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'auth_provider.dart';

class ProjetProvider {
  // Create a new project
  static Future<Map<String, dynamic>> createProjet(Map<String, dynamic> projetData) async {
    try {
      // Use basic headers without authentication
      final headers = {
        'Content-Type': 'application/json',
      };
      
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.projets}'),
        headers: headers,
        body: json.encode(projetData),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to create project';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error creating project: $e'};
    }
  }

  // Get all projects
  static Future<Map<String, dynamic>> getAllProjets() async {
    try {
      // Use basic headers without authentication
      final headers = {
        'Content-Type': 'application/json',
      };
      
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.projets}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'projects': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get projects';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching projects: $e'};
    }
  }

  // Get a specific project
  static Future<Map<String, dynamic>> getProjet(int projetId) async {
    try {
      // Use basic headers without authentication
      final headers = {
        'Content-Type': 'application/json',
      };
      
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.projets}/$projetId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'project': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get project';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching project: $e'};
    }
  }

  // Update project
  static Future<Map<String, dynamic>> updateProjet(int projetId, Map<String, dynamic> projetData) async {
    try {
      // Use basic headers without authentication
      final headers = {
        'Content-Type': 'application/json',
      };
      
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.projets}/$projetId'),
        headers: headers,
        body: json.encode(projetData),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to update project';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating project: $e'};
    }
  }

  // Delete project
  static Future<Map<String, dynamic>> deleteProjet(int projetId) async {
    try {
      // Use basic headers without authentication
      final headers = {
        'Content-Type': 'application/json',
      };
      
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.projets}/$projetId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to delete project';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting project: $e'};
    }
  }
}