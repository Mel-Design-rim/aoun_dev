import 'package:flutter/material.dart';
import 'package:aoun_dev/src/widgets/cards.dart';
import 'package:aoun_dev/src/utils/constants.dart';
import 'package:aoun_dev/src/widgets/navigationBar.dart';
import 'package:aoun_dev/src/widgets/notification_dialog.dart';
import 'package:aoun_dev/src/controllers/project_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final ProjectController _projectController = Get.find<ProjectController>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    // Refresh projects when screen loads
    _projectController.fetchProjects();
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Notification icon
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const NotificationDialog(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: thirdColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App name and slogan
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'عـــــــــون',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Zain-Bold',
                                fontSize: 26,
                              ),
                            ),
                            Text(
                              'مسيرة عطاء و نور احسـان',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        // Logo
                        Container(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: const Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.5),
                      height: 42,
                      width: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: thirdColor,
                          borderRadius: BorderRadius.circular(50),
                        ),

                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'ابحث عن جمعيات',
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            suffixIcon: Icon(Icons.search, color: Colors.white),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Categories section title
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Text(
                    'الجمعيات والمبادرات:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Categories horizontal list
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(
                    10,
                    (i) => Row(
                      children: [
                        logos("/images/A/1.png"),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 3,
                child: Obx(() {
                  if (_projectController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    );
                  } else if (_projectController.projects.isNotEmpty) {
                    // Display the first project in the large card
                    final featuredProject = _projectController.projects[0];
                    return largCards(
                      '/images/imagesForTest/1.png', // Keep default image for now
                      featuredProject['title'].toString(),
                      featuredProject['ets'].toString(),
                      double.parse(featuredProject['done'].toString()),
                      projectData: featuredProject,
                    );
                  } else {
                    return largCards(
                      '/images/imagesForTest/1.png',
                      "افطــار الإحسان",
                      "جمعية قلوب محسنة",
                      20,
                    );
                  }
                }),
              ),
              const SizedBox(height: 20),
              // Progress container
              Expanded(
                flex: 5,
                child: Obx(() {
                  if (_projectController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    );
                  } else if (_projectController.error.value.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _projectController.error.value,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _projectController.fetchProjects(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    );
                  } else if (_projectController.projects.isEmpty) {
                    return const Center(
                      child: Text(
                        'لا توجد مشاريع متاحة حالياً',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return SizedBox(
                      child: RefreshIndicator(
                        color: primaryColor,
                        onRefresh: () async {
                          await _projectController.fetchProjects();
                        },
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                childAspectRatio: 1.4,
                                crossAxisCount: 2,
                              ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: _projectController.projects.length,
                          itemBuilder: (context, index) {
                            final project = _projectController.projects[index];
                            return miniCards(
                              project['title'].toString(),
                              project['ets'].toString(),
                              double.parse(project['done'].toString()),
                              projectData: project,
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
