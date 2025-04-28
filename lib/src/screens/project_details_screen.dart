import 'package:flutter/material.dart';
import 'package:aoun_dev/src/utils/constants.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> projectData;

  const ProjectDetailsScreen({super.key, required this.projectData});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  bool isFavorite = false;
  int selectedDonationAmount = 200000; // Default selected amount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and favorite button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  // Project title
                  Text(
                    widget.projectData['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Favorite button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main content - scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Project image
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/imagesForTest/1.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Project details section
                      _buildSectionTitle('التفاصيل'),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          widget.projectData['details'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Target audience section
                      _buildSectionTitle('الفئة المستهدفة'),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.only(right: 40),
                        child: Text(
                          widget.projectData['audiance'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Organization section
                      _buildSectionTitle('المؤسسة المشرفة'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: const EdgeInsets.only(left: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.projectData['ets'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'خيرية تأسست عام 2015 تطمح\nلتركها أثر على المجتمع وأهمية له\nنشر العلم و الشمس الخيرة و صرف\nكل أنواع من الإحسان بإهتمام\nمتعددة',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),

                      const SizedBox(height: 30),
                      const Divider(color: primaryColor, thickness: 0.5),
                      const SizedBox(height: 20),

                      // Donation amount options
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDonationOption(200000, ':المتبقي', 3),
                          _buildDonationOption(200000, ':المتحصل عليه', 2),
                          _buildDonationOption(400000, ':الهدف', 1),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Text(
        title,
        style: const TextStyle(
          color: primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDonationOption(int amount, String label, int index) {
    Color c = Colors.white;
    if (index == 2) {
      c = bgColor;
    }
    ;
    return GestureDetector(
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              index == 1
                  ? thirdColor
                  : index == 2
                  ? primaryColor
                  : worning,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: c,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$amount',
              style: TextStyle(
                color: c,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'اوقية',
              style: TextStyle(
                color: c,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
