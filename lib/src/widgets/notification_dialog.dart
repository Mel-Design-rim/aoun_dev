import 'package:flutter/material.dart';
import 'package:aoun_dev/src/utils/constants.dart';
import 'package:aoun_dev/src/controllers/notification_controller.dart';
import 'package:get/get.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: primaryColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
                const Text(
                  'الإشعارات',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Zain-Bold',
                  ),
                ),
              ],
            ),
            const Divider(color: primaryColor),
            GetX<NotificationController>(
              builder: (controller) {
                final recentNotifications = controller.getRecentNotifications(5);
                
                return recentNotifications.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: recentNotifications.length,
                        itemBuilder: (context, index) {
                          final notification = recentNotifications[index];
                          return _buildNotificationItem(
                            notification['title'] ?? '',
                            notification['body'] ?? '',
                            notification['time'] ?? '',
                            notification['isRead'] ?? false,
                            () {
                              // Mark as read when tapped
                              controller.markAsRead(controller.notifications.indexOf(notification));
                            },
                          );
                        },
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: Text(
                          'لا يوجد إشعارات',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
              },
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                  Get.toNamed('/notifications'); // Navigate to notifications screen using GetX
                },
                child: const Text(
                  'عرض كل الإشعارات',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String message, String time, bool isRead, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isRead ? thirdColor.withOpacity(0.7) : thirdColor,
          borderRadius: BorderRadius.circular(10),
          border: isRead ? null : Border.all(color: primaryColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Row(
                  children: [
                    if (!isRead)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              message,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
