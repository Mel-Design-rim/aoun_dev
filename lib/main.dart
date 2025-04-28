import 'package:flutter/material.dart';
import 'package:aoun_dev/src/screens/splash_screen.dart';
import 'package:aoun_dev/src/widgets/cards.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: 'Zain-Light'),

      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
