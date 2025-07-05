import 'package:flutter/material.dart';
import 'package:aoun_dev/src/utils/constants.dart';
import 'package:get/get.dart';
import 'package:aoun_dev/src/controllers/project_controller.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final int projectId;
  
  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  bool isFavorite = false;
  int selectedDonationAmount = 200000; // Default selected amount
  final ProjectController projectController = Get.find<ProjectController>();
  bool isLoading = true; // Start with loading state
  Map<String, dynamic> projectDetails = {};
  
  @override
  void initState() {
    super.initState();
    // Fetch project details using the provided projectId
    _fetchProjectDetails(widget.projectId);
  }
  
  Future<void> _fetchProjectDetails(int projectId) async {
    try {
      final result = await projectController.getProject(projectId);
      if (!result.containsKey('error')) {
        setState(() {
          projectDetails = result;
          isLoading = false;
        });
      } else {
        // Show error message
        Get.snackbar(
          'Error',
          'Failed to load project details: ${result['error']}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to load project details: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: isLoading 
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : Column(
          children: [
            // Header with back button and favorite button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Get.back(),
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
                    projectDetails['title'] ?? 'Project Title',
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
                              'assets/images/project_placeholder.png',
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
                          projectDetails['details'] ?? 'No details available',
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
                          projectDetails['audiance'] ?? 'No target audience specified',
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
                                      'assets/images/association_placeholder.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      projectDetails['ets'] ?? 'Organization Name',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      projectDetails['description'] ?? '',
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
                          _buildDonationOption(
                            _calculateRemaining(projectDetails),
                            ':المتبقي',
                            3
                          ),
                          _buildDonationOption(
                            projectDetails['montant_recu'] != null 
                              ? (projectDetails['montant_recu'] as num).toInt() 
                              : 0,
                            ':المتحصل عليه',
                            2
                          ),
                          _buildDonationOption(
                            projectDetails['montant'] != null 
                              ? (projectDetails['montant'] as num).toInt() 
                              : 0,
                            ':الهدف',
                            1
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Donation button
                      GestureDetector(
                        onTap: () {
                          // Handle donation action
                          if (projectDetails.containsKey('id')) {
                            _handleDonation(projectDetails['id']);
                          } else {
                            // Use the widget's projectId as fallback
                            _handleDonation(widget.projectId);
                          }
                        },
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'تبرع الآن',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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

  // Calculate remaining amount needed for the project
  int _calculateRemaining(Map<String, dynamic> project) {
    if (project.containsKey('montant') && project.containsKey('montant_recu')) {
      final total = (project['montant'] as num).toInt();
      final received = (project['montant_recu'] as num).toInt();
      return total > received ? total - received : 0;
    }
    return 0; // No default value, show 0 if data is not available
  }

  // Handle donation action
  void _handleDonation(int projectId) {
    // TODO: Implement donation functionality
    // This would typically navigate to a donation screen or show a donation dialog
    Get.snackbar(
      'Donation',
      'Donation feature will be implemented soon for project ID: $projectId',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: primaryColor,
      colorText: Colors.white,
    );
  }

  Widget _buildDonationOption(int amount, String label, int index) {
    Color c = Colors.white;
    if (index == 2) {
      c = bgColor;
    }
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
