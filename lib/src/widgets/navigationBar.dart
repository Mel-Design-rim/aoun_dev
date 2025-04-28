import 'package:flutter/material.dart';
import 'package:aoun_dev/src/utils/constants.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: primaryColor, width: 1),
          left: BorderSide(color: primaryColor, width: 1),
          right: BorderSide(color: primaryColor, width: 1),
        ),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   topRight: Radius.circular(20),
        // ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, Icons.home, 'الرئيسية', 0),
          _buildNavItem(
            Icons.dashboard_outlined,
            Icons.dashboard,
            'المشاريع',
            1,
          ),
          _buildNavItem(Icons.person_outline, Icons.person, 'الحساب', 2),
          _buildNavItem(
            Icons.notifications_outlined,
            Icons.notifications,
            'الإشعارات',
            3,
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(
    IconData outlinedIcon,
    IconData filledIcon,
    String label,
    int index,
  ) {
    final bool isSelected = widget.currentIndex == index;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? thirdColor : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => widget.onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? filledIcon : outlinedIcon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
