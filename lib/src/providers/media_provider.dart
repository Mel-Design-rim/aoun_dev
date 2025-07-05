import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class MediaProvider {
  // Upload a new media
  static Future<Map<String, dynamic>> uploadMedia(Map<String, dynamic> mediaData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.medias}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(mediaData),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to upload media';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error uploading media: $e'};
    }
  }

  // Get all media
  static Future<Map<String, dynamic>> getAllMedia() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.medias}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'media': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get media';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching media: $e'};
    }
  }

  // Get media for a specific project
  static Future<Map<String, dynamic>> getMediaByProjet(int projetId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.medias}/projet/$projetId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'media': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get media for project';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching media for project: $e'};
    }
  }

  // Get a specific media
  static Future<Map<String, dynamic>> getMedia(int mediaId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.medias}/$mediaId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'media': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get media';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching media: $e'};
    }
  }

  // Update media
  static Future<Map<String, dynamic>> updateMedia(int mediaId, Map<String, dynamic> mediaData) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.medias}/$mediaId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(mediaData),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to update media';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating media: $e'};
    }
  }

  // Delete media
  static Future<Map<String, dynamic>> deleteMedia(int mediaId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.medias}/$mediaId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to delete media';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting media: $e'};
    }
  }
}