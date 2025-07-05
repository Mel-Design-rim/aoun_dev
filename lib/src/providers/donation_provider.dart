import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'auth_provider.dart';

class DonationProvider {
  // Create a new donation
  static Future<Map<String, dynamic>> createDonation(Map<String, dynamic> donationData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.donations}'),
        headers: await AuthProvider.getAuthHeaders(),
        body: json.encode(donationData),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to create donation';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error creating donation: $e'};
    }
  }

  // Get all donations
  static Future<Map<String, dynamic>> getAllDonations() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.donations}'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'donations': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get donations';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching donations: $e'};
    }
  }

  // Get donations for a specific project
  static Future<Map<String, dynamic>> getDonationsByProjet(int projetId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.donations}/projet/$projetId'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'donations': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get donations for project';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching donations for project: $e'};
    }
  }

  // Get donations for a specific user
  static Future<Map<String, dynamic>> getDonationsByUser(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.donations}/user/$userId'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'donations': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get donations for user';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching donations for user: $e'};
    }
  }

  // Get a specific donation
  static Future<Map<String, dynamic>> getDonation(int donationId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.donations}/$donationId'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'donation': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get donation';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching donation: $e'};
    }
  }

  // Update donation
  static Future<Map<String, dynamic>> updateDonation(int donationId, Map<String, dynamic> donationData) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.donations}/$donationId'),
        headers: await AuthProvider.getAuthHeaders(),
        body: json.encode(donationData),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to update donation';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating donation: $e'};
    }
  }

  // Delete donation
  static Future<Map<String, dynamic>> deleteDonation(int donationId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.donations}/$donationId'),
        headers: await AuthProvider.getAuthHeaders(),
      );
      
      if (response.statusCode == 401) {
        await AuthProvider.logout();
        return {'success': false, 'error': 'Unauthorized. Please login again.'};  
      }

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to delete donation';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting donation: $e'};
    }
  }
}