import 'package:flutter/material.dart';
import 'package:aoun_dev/src/utils/constants.dart';
import 'package:aoun_dev/src/widgets/navigationBar.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  int _currentIndex = 1; // Start with second tab selected

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Here you can add navigation logic if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text('مثال للشاشة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'مثال لاستخدام شريط التنقل',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'الصفحة الحالية: ${_getPageName(_currentIndex)}',
              style: const TextStyle(color: primaryColor, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  String _getPageName(int index) {
    switch (index) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'لوحة التحكم';
      case 2:
        return 'الملف الشخصي';
      case 3:
        return 'الإشعارات';
      default:
        return '';
    }
  }
}
