import 'package:flutter/material.dart';
import 'package:aoun_dev/src/screens/splash_screen.dart';
import 'package:aoun_dev/src/screens/notifications_screen.dart';
import 'package:aoun_dev/src/widgets/cards.dart';
import 'package:get/get.dart';
import 'package:aoun_dev/src/controllers/notification_controller.dart';
import 'package:aoun_dev/src/controllers/project_controller.dart';

void main() {
  // Initialize controllers
  Get.put(NotificationController());
  Get.put(ProjectController());
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: 'Zain-Light'),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/notifications', page: () => const NotificationsScreen()),
      ],
    );
  }
}
