import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'auth_provider.dart';

class AssociationProvider {
  // Create a new association
  static Future<Map<String, dynamic>> createAssociation(Map<String, dynamic> associationData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.associations}'),
        headers: await AuthProvider.getAuthHeaders(),
        body: json.encode(associationData),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to create association';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error creating association: $e'};
    }
  }

  // Get all associations
  static Future<Map<String, dynamic>> getAllAssociations() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.associations}'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'associations': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get associations';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching associations: $e'};
    }
  }

  // Get a specific association
  static Future<Map<String, dynamic>> getAssociation(int associationId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.associations}/$associationId'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'association': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get association';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching association: $e'};
    }
  }

  // Update association
  static Future<Map<String, dynamic>> updateAssociation(int associationId, Map<String, dynamic> associationData) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.associations}/$associationId'),
        headers: await AuthProvider.getAuthHeaders(),
        body: json.encode(associationData),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to update association';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating association: $e'};
    }
  }

  // Delete association
  static Future<Map<String, dynamic>> deleteAssociation(int associationId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.associations}/$associationId'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to delete association';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting association: $e'};
    }
  }
}