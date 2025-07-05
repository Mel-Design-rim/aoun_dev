import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../providers/api_config.dart';
import '../providers/auth_provider.dart';
// Import for test data - will be removed when backend is fully connected
import '../providers/api_notifications.dart';

class NotificationController extends GetxController {
  // Observable list of notifications
  final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;
  
  // Observable unread count
  final RxInt unreadCount = 0.obs;
  
  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotificationsFromApi();
  }

  // Initialize notifications from mock data
  void _initializeNotifications() {
    // Convert the mock data to include additional fields
    notifications.value = notify.map((notification) {
      // Add isRead and date fields if they don't exist
      final Map<String, dynamic> notificationWithFields = Map.from(notification);
      
      // Set default values if not present
      notificationWithFields['isRead'] = notificationWithFields['isRead'] ?? false;
      notificationWithFields['date'] = notificationWithFields['date'] ?? _getDateFromTime(notification['time'] ?? '');
      
      // Add a type field based on the title (for demonstration)
      notificationWithFields['type'] = _getTypeFromTitle(notification['title'] ?? '');
      
      return notificationWithFields;
    }).toList();
    
    // Calculate unread count
    _updateUnreadCount();
  }
  
  // Helper method to determine notification type from title
  String _getTypeFromTitle(String title) {
    if (title.contains('تبرع') || title.contains('تبرعات')) {
      return 'donation';
    } else if (title.contains('مشروع') || title.contains('مشاريع')) {
      return 'project';
    } else if (title.contains('تحديث')) {
      return 'update';
    } else if (title.contains('شكر') || title.contains('تكريم')) {
      return 'thanks';
    } else if (title.contains('تذكير')) {
      return 'reminder';
    } else {
      return 'general';
    }
  }
  
  // Helper method to determine date from time string
  String _getDateFromTime(String time) {
    if (time.contains('ص') || time.contains('م')) {
      return 'اليوم';
    } else if (time.contains('أمس')) {
      return 'أمس';
    } else if (time.contains('يومين')) {
      return 'منذ يومين';
    } else if (time.contains('أيام')) {
      return time;
    } else if (time.contains('أسبوع')) {
      return time;
    } else if (time.contains('شهر')) {
      return time;
    } else {
      return 'اليوم';
    }
  }
  
  // Update unread count
  void _updateUnreadCount() {
    unreadCount.value = notifications.where((notification) => notification['isRead'] == false).length;
  }
  
  // Mark a notification as read
  Future<void> markAsRead(int index) async {
    if (index >= 0 && index < notifications.length) {
      // Update locally first for immediate UI feedback
      notifications[index]['isRead'] = true;
      _updateUnreadCount();
      
      // Then update on the backend
      try {
        final notificationId = notifications[index]['id'];
        if (notificationId != null) {
          final result = await markNotificationAsReadInApi(notificationId);
          if (!result['success']) {
            print('Failed to mark notification as read on server: ${result['error']}');
          }
        }
      } catch (e) {
        print('Error marking notification as read on server: $e');
      }
    }
  }
  
  // Mark all notifications as read
  Future<void> markAllAsRead() async {
    // Update locally first for immediate UI feedback
    for (var i = 0; i < notifications.length; i++) {
      notifications[i] = {...notifications[i], 'isRead': true};
    }
    _updateUnreadCount();
    
    // Then update on the backend
    try {
      // Ideally, the backend would have a bulk update endpoint
      // For now, we'll update each notification individually
      for (var notification in notifications) {
        final notificationId = notification['id'];
        if (notificationId != null && notification['isRead'] == true) {
          await markNotificationAsReadInApi(notificationId);
        }
      }
    } catch (e) {
      print('Error marking all notifications as read on server: $e');
    }
  }
  
  // Get recent notifications (limited number)
  List<Map<String, dynamic>> getRecentNotifications(int limit) {
    return notifications.take(limit).toList();
  }
  
  // Filter notifications by type
  List<Map<String, dynamic>> getNotificationsByType(String type) {
    return notifications.where((notification) => notification['type'] == type).toList();
  }
  
  // Filter notifications by read status
  List<Map<String, dynamic>> getNotificationsByReadStatus(bool isRead) {
    return notifications.where((notification) => notification['isRead'] == isRead).toList();
  }
  
  // Create a new notification
  Future<Map<String, dynamic>> createNotification(Map<String, dynamic> notificationData) async {
    try {
      // Get auth headers
      final headers = await AuthProvider.getAuthHeaders();
      
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.notifications}'),
        headers: headers,
        body: json.encode(notificationData),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else if (response.statusCode == 401) {
        // Unauthorized - token might be expired
        await AuthProvider.logout();
        return {'success': false, 'error': 'Session expired. Please login again.'};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to create notification';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error creating notification: $e'};
    }
  }

  // Get all notifications from API
  Future<Map<String, dynamic>> getAllNotificationsFromApi() async {
    try {
      // Get auth headers
      final headers = await AuthProvider.getAuthHeaders();
      
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.notifications}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'notifications': json.decode(response.body)};
      } else if (response.statusCode == 401) {
        // Unauthorized - token might be expired
        await AuthProvider.logout();
        return {'success': false, 'error': 'Session expired. Please login again.'};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get notifications';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching notifications: $e'};
    }
  }

  // Get notifications for a specific user from API
  Future<Map<String, dynamic>> getNotificationsByUserFromApi(int userId) async {
    try {
      // Get auth headers
      final headers = await AuthProvider.getAuthHeaders();
      
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.notifications}/user/$userId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'notifications': json.decode(response.body)};
      } else if (response.statusCode == 401) {
        // Unauthorized - token might be expired
        await AuthProvider.logout();
        return {'success': false, 'error': 'Session expired. Please login again.'};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get notifications for user';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching notifications for user: $e'};
    }
  }

  // Get a specific notification from API
  Future<Map<String, dynamic>> getNotificationFromApi(int notificationId) async {
    try {
      // Get auth headers
      final headers = await AuthProvider.getAuthHeaders();
      
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.notifications}/$notificationId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'notification': json.decode(response.body)};
      } else if (response.statusCode == 401) {
        // Unauthorized - token might be expired
        await AuthProvider.logout();
        return {'success': false, 'error': 'Session expired. Please login again.'};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to get notification';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error fetching notification: $e'};
    }
  }

  // Mark notification as read in API
  Future<Map<String, dynamic>> markNotificationAsReadInApi(int notificationId) async {
    try {
      // Get auth headers
      final headers = await AuthProvider.getAuthHeaders();
      
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.notifications}/$notificationId/read'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else if (response.statusCode == 401) {
        // Unauthorized - token might be expired
        await AuthProvider.logout();
        return {'success': false, 'error': 'Session expired. Please login again.'};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to mark notification as read';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error marking notification as read: $e'};
    }
  }

  // Delete notification from API
  Future<Map<String, dynamic>> deleteNotificationFromApi(int notificationId) async {
    try {
      // Get auth headers
      final headers = await AuthProvider.getAuthHeaders();
      
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.notifications}/$notificationId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': json.decode(response.body)['message']};
      } else if (response.statusCode == 401) {
        // Unauthorized - token might be expired
        await AuthProvider.logout();
        return {'success': false, 'error': 'Session expired. Please login again.'};
      } else {
        final error = json.decode(response.body)['error'] ?? 'Failed to delete notification';
        return {'success': false, 'error': error};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting notification: $e'};
    }
  }
  
  // Add a new notification to both local list and backend
  Future<Map<String, dynamic>> addNotification(Map<String, dynamic> notification) async {
    // Ensure required fields are present
    if (!notification.containsKey('title') || !notification.containsKey('body')) {
      return {'success': false, 'error': 'Title and body are required'};
    }
    
    // Prepare notification data for API
    final Map<String, dynamic> apiNotification = {
      'title': notification['title'],
      'body': notification['body'],
      'user_id': notification['user_id'] ?? 1, // Default to user 1 if not specified
      'is_read': notification['isRead'] ?? false,
      // Add any other fields required by your API
    };
    
    try {
      // Send to backend first
      final result = await createNotification(apiNotification);
      
      if (result['success']) {
        // If successful, add to local list with API response data
        final Map<String, dynamic> newNotification = {
          'title': notification['title'],
          'body': notification['body'],
          'time': notification['time'] ?? 'الآن',
          'isRead': notification['isRead'] ?? false,
          'date': notification['date'] ?? 'اليوم',
          'type': notification['type'] ?? _getTypeFromTitle(notification['title']),
          'id': result['notification_id'] ?? null, // Get ID from API response if available
        };
        
        // Add to the beginning of the list
        notifications.insert(0, newNotification);
        
        // Update unread count
        _updateUnreadCount();
        
        return {'success': true, 'notification': newNotification};
      } else {
        // If API call fails, still add locally but log the error
        print('Failed to add notification to backend: ${result['error']}');
        
        // Add default values if not present
        final Map<String, dynamic> newNotification = Map.from(notification);
        newNotification['time'] = newNotification['time'] ?? 'الآن';
        newNotification['isRead'] = newNotification['isRead'] ?? false;
        newNotification['date'] = newNotification['date'] ?? 'اليوم';
        newNotification['type'] = newNotification['type'] ?? _getTypeFromTitle(notification['title']);
        
        // Add to the beginning of the list
        notifications.insert(0, newNotification);
        
        // Update unread count
        _updateUnreadCount();
        
        return {'success': true, 'notification': newNotification, 'warning': 'Added locally only'};
      }
    } catch (e) {
      // If there's an error, still add locally but log the error
      print('Error adding notification to backend: $e');
      
      // Add default values if not present
      final Map<String, dynamic> newNotification = Map.from(notification);
      newNotification['time'] = newNotification['time'] ?? 'الآن';
      newNotification['isRead'] = newNotification['isRead'] ?? false;
      newNotification['date'] = newNotification['date'] ?? 'اليوم';
      newNotification['type'] = newNotification['type'] ?? _getTypeFromTitle(notification['title']);
      
      // Add to the beginning of the list
      notifications.insert(0, newNotification);
      
      // Update unread count
      _updateUnreadCount();
      
      return {'success': true, 'notification': newNotification, 'warning': 'Added locally only, error: $e'};
    }
  }
  
  // Update a notification in the local list
  void updateNotification(int index, Map<String, dynamic> updatedFields) {
    if (index >= 0 && index < notifications.length) {
      // Create a new map with updated fields
      Map<String, dynamic> updatedNotification = Map.from(notifications[index]);
      
      // Update only the fields that are provided
      updatedFields.forEach((key, value) {
        updatedNotification[key] = value;
      });
      
      // Update the notification in the list
      notifications[index] = updatedNotification;
      
      // Update unread count if isRead field was updated
      if (updatedFields.containsKey('isRead')) {
        _updateUnreadCount();
      }
    }
  }
  
  // Delete a notification from both local list and backend
  Future<Map<String, dynamic>> deleteNotification(int index) async {
    if (index >= 0 && index < notifications.length) {
      final notification = notifications[index];
      final notificationId = notification['id'];
      
      // Remove from local list first for immediate UI feedback
      notifications.removeAt(index);
      
      // Update unread count
      _updateUnreadCount();
      
      // Then delete from backend if we have an ID
      if (notificationId != null) {
        try {
          final result = await deleteNotificationFromApi(notificationId);
          
          if (result['success']) {
            return {'success': true, 'message': 'Notification deleted successfully'};
          } else {
            print('Failed to delete notification from backend: ${result['error']}');
            return {'success': true, 'warning': 'Deleted locally only, server error: ${result['error']}'};
          }
        } catch (e) {
          print('Error deleting notification from backend: $e');
          return {'success': true, 'warning': 'Deleted locally only, error: $e'};
        }
      } else {
        // No ID means it was probably a local-only notification
        return {'success': true, 'warning': 'Deleted locally only (no server ID)'};
      }
    } else {
      return {'success': false, 'error': 'Invalid notification index'};
    }
  }
  
  // Fetch notifications from API
  Future<void> fetchNotificationsFromApi() async {
    try {
      // Show loading state
      isLoading.value = true;
      
      // Check if user is logged in
      final isLoggedIn = await AuthProvider.isLoggedIn();
      if (!isLoggedIn) {
        // If not logged in, use mock data as fallback
        _initializeNotifications();
        print('User not logged in, using mock data');
        isLoading.value = false;
        return;
      }
      
      // Get user ID
      final userId = await AuthProvider.getUserId();
      if (userId == null) {
        // If no user ID, use mock data as fallback
        _initializeNotifications();
        print('No user ID found, using mock data');
        isLoading.value = false;
        return;
      }
      
      // Get notifications for the current user
      final result = await getNotificationsByUserFromApi(int.parse(userId));
      
      if (result['success']) {
        // Convert API response to the format we need
        final apiNotifications = result['notifications'] as List<dynamic>;
        
        if (apiNotifications.isEmpty) {
          // If no notifications, clear the list
          notifications.clear();
          _updateUnreadCount();
        } else {
          notifications.value = apiNotifications.map((notification) {
            // Convert API notification to our format
            final Map<String, dynamic> formattedNotification = {
              'title': notification['title'] ?? '',
              'body': notification['body'] ?? '',
              'time': _formatTimeFromApi(notification['created_at'] ?? ''),
              'isRead': notification['is_read'] ?? false,
              'id': notification['id'],
              'type': _getTypeFromTitle(notification['title'] ?? ''),
              'date': _formatDateFromApi(notification['created_at'] ?? ''),
            };
            
            return formattedNotification;
          }).toList();
          
          // Update unread count
          _updateUnreadCount();
        }
      } else {
        // If API call fails, use mock data as fallback
        _initializeNotifications();
        print('Failed to fetch notifications: ${result['error']}');
      }
    } catch (e) {
      // If there's an error, use mock data as fallback
      _initializeNotifications();
      print('Error fetching notifications: $e');
    } finally {
      // Hide loading state
      isLoading.value = false;
    }
  }
  
  // Format time from API timestamp
  String _formatTimeFromApi(String timestamp) {
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);
      
      if (difference.inDays == 0) {
        // Today - show time
        return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour < 12 ? 'ص' : 'م'}';
      } else if (difference.inDays == 1) {
        // Yesterday
        return 'أمس';
      } else if (difference.inDays == 2) {
        // 2 days ago
        return 'منذ يومين';
      } else if (difference.inDays < 7) {
        // Less than a week
        return 'منذ ${difference.inDays} أيام';
      } else if (difference.inDays < 14) {
        // Less than 2 weeks
        return 'منذ أسبوع';
      } else if (difference.inDays < 30) {
        // Less than a month
        return 'منذ ${(difference.inDays / 7).floor()} أسابيع';
      } else {
        // More than a month
        return 'منذ ${(difference.inDays / 30).floor()} شهر';
      }
    } catch (e) {
      return 'الآن';
    }
  }
  
  // Format date from API timestamp
  String _formatDateFromApi(String timestamp) {
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);
      
      if (difference.inDays == 0) {
        return 'اليوم';
      } else if (difference.inDays == 1) {
        return 'أمس';
      } else if (difference.inDays == 2) {
        return 'منذ يومين';
      } else if (difference.inDays < 7) {
        return 'منذ ${difference.inDays} أيام';
      } else if (difference.inDays < 30) {
        return 'منذ ${(difference.inDays / 7).floor()} أسابيع';
      } else {
        return 'منذ ${(difference.inDays / 30).floor()} شهر';
      }
    } catch (e) {
      return 'اليوم';
    }
  }
  
  // Refresh notifications from API
  Future<void> refreshNotifications() async {
    await fetchNotificationsFromApi();
  }
}