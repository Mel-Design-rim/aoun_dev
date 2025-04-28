# Custom Navigation Bar Usage Guide

## Overview
This guide explains how to use the custom navigation bar that has been created for the Aoun application. The navigation bar is designed with a modern look that matches the app's theme and includes four navigation items: Home, Dashboard, Profile, and Notifications.

## How to Use

### 1. Import the Navigation Bar
In any screen where you want to use the navigation bar, import it at the top of your file:

```dart
import 'package:aoun_dev/src/widgets/navigationBar.dart';
```

### 2. Add the Navigation Bar to Your Scaffold
In your screen's build method, add the CustomNavigationBar to the bottomNavigationBar property of your Scaffold:

```dart
Scaffold(
  // Your other scaffold properties
  bottomNavigationBar: CustomNavigationBar(
    currentIndex: _currentIndex,  // The currently selected tab index
    onTap: _onNavTap,            // Function to handle tab changes
  ),
  // Your scaffold body
)
```

### 3. Implement State Management
In your StatefulWidget's State class, add the following:

```dart
int _currentIndex = 0;  // Default to first tab (Home)

void _onNavTap(int index) {
  setState(() {
    _currentIndex = index;
  });
  // Add navigation logic here if needed
}
```

## Example Implementation

Here's a complete example of how to implement the navigation bar in a screen:

```dart
import 'package:flutter/material.dart';
import 'package:aoun_dev/src/utils/constants.dart';
import 'package:aoun_dev/src/widgets/navigationBar.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
      body: Center(
        child: Text('Content for tab $_currentIndex'),
      ),
    );
  }
}
```

## Features

- The navigation bar automatically highlights the selected tab
- Each tab has both an outlined (unselected) and filled (selected) icon
- The navigation bar uses the app's color scheme
- Arabic labels for each navigation item
- Smooth rounded corners at the top of the navigation bar

## Navigation Items

1. الرئيسية (Home) - Index 0
2. لوحة التحكم (Dashboard) - Index 1
3. الملف الشخصي (Profile) - Index 2
4. الإشعارات (Notifications) - Index 3