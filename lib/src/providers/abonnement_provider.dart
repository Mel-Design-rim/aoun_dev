import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class AbonnementProvider {
  // Create a new subscription
  static Future<Map<String, dynamic>> createAbonnement(Map<String, dynamic> abonnementData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.abonnements}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(abonnementData),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to create subscription';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error creating subscription: $e'};
    }
  }

  // Get all subscriptions
  static Future<Map<String, dynamic>> getAllAbonnements() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.abonnements}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'subscriptions': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get subscriptions';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching subscriptions: $e'};
    }
  }

  // Get subscriptions for a specific user
  static Future<Map<String, dynamic>> getAbonnementsByUser(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.abonnements}/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'subscriptions': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get subscriptions for user';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching subscriptions for user: $e'};
    }
  }

  // Get subscriptions for a specific association
  static Future<Map<String, dynamic>> getAbonnementsByAssociation(int associationId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.abonnements}/association/$associationId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'subscriptions': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get subscriptions for association';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching subscriptions for association: $e'};
    }
  }

  // Get a specific subscription
  static Future<Map<String, dynamic>> getAbonnement(int abonnementId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.abonnements}/$abonnementId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'subscription': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get subscription';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching subscription: $e'};
    }
  }

  // Update subscription
  static Future<Map<String, dynamic>> updateAbonnement(int abonnementId, Map<String, dynamic> abonnementData) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.abonnements}/$abonnementId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(abonnementData),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to update subscription';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating subscription: $e'};
    }
  }

  // Delete subscription
  static Future<Map<String, dynamic>> deleteAbonnement(int abonnementId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.abonnements}/$abonnementId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to delete subscription';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting subscription: $e'};
    }
  }
}