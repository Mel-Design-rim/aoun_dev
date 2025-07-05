import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class CommentaireProvider {
  // Create a new comment
  static Future<Map<String, dynamic>> createCommentaire(Map<String, dynamic> commentaireData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.commentaires}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(commentaireData),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to create comment';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error creating comment: $e'};
    }
  }

  // Get all comments
  static Future<Map<String, dynamic>> getAllCommentaires() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.commentaires}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'comments': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get comments';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching comments: $e'};
    }
  }

  // Get comments for a specific project
  static Future<Map<String, dynamic>> getCommentairesByProjet(int projetId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.commentaires}/projet/$projetId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'comments': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get comments for project';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching comments for project: $e'};
    }
  }

  // Get a specific comment
  static Future<Map<String, dynamic>> getCommentaire(int commentaireId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.commentaires}/$commentaireId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'comment': json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get comment';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching comment: $e'};
    }
  }

  // Update comment
  static Future<Map<String, dynamic>> updateCommentaire(int commentaireId, Map<String, dynamic> commentaireData) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.commentaires}/$commentaireId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(commentaireData),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to update comment';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating comment: $e'};
    }
  }

  // Delete comment
  static Future<Map<String, dynamic>> deleteCommentaire(int commentaireId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.commentaires}/$commentaireId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to delete comment';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting comment: $e'};
    }
  }
}