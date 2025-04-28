import 'package:flutter/material.dart';
import 'package:aoun_dev/src/utils/constants.dart';
import 'package:aoun_dev/src/screens/project_details_screen.dart';

// Global navigator key for accessing context from outside of build
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainContent extends StatelessWidget {
  const MainContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

Widget logos(String imagePath) {
  return ClipRRect(
    clipBehavior: Clip.hardEdge,
    borderRadius: BorderRadius.circular(50),
    child: SizedBox(
      width: 58,
      height: 58,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: primaryColor,
            width: 2,
            style: BorderStyle.solid,
          ),
          boxShadow: [BoxShadow(color: primaryColor, blurRadius: 5)],
        ),
        child: Image(
          //adding shadow to the image
          image: Image.asset(imagePath).image,
          fit: BoxFit.fill,
          height: 58,
          width: 58,
        ),
      ),
    ),
  );
}

Widget miniCards(
  String title,
  String ets,
  double done, {
  VoidCallback? onTap,
  Map<String, dynamic>? projectData,
}) {
  return InkWell(
    onTap:
        onTap ??
        () {
          if (projectData != null) {
            Navigator.push(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                builder:
                    (context) => ProjectDetailsScreen(projectData: projectData),
              ),
            );
          }
        },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: thirdColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Transform.rotate(
                  angle: 0.8,
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 15),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ets,
                    style: const TextStyle(
                      fontFamily: "Zain-Light",
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            minHeight: 10,
            value: done / 100,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$done%مكتمل',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontFamily: "Zain-Light",
                ),
              ),
              Text(
                '${100 - done}%متبقي',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontFamily: "Zain-Light",
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget largCards(String imagePath, String title, String ets, double done) {
  return Card(
    clipBehavior: Clip.hardEdge,
    elevation: 10,
    borderOnForeground: true,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Stack(
      children: [
        // Background image that covers the entire card
        Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),
        // Semi-transparent overlay to make text readable
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // ignore: deprecated_member_use
                colors: [primaryColor.withOpacity(0), primaryColor],
              ),
            ),
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: bgColor.withOpacity(0.78),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white, width: 01),
                ),
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: thirdColor,
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        CircularProgressIndicator(
                          value: done / 100,
                          strokeWidth: 5,
                          strokeCap: StrokeCap.round,

                          strokeAlign: BorderSide.strokeAlignOutside,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                        Text(
                          '${(done).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ets,
                            style: const TextStyle(
                              fontFamily: "Zain-Light",
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
