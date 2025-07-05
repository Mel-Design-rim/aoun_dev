import 'package:get/get.dart';
import 'package:aoun_dev/src/providers/projet_provider.dart';

class ProjectController extends GetxController {
  // Observable list of projects
  final RxList<Map<String, dynamic>> projects = <Map<String, dynamic>>[].obs;
  
  // Loading state
  final RxBool isLoading = false.obs;
  
  // Error state
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjects();
  }

  // Fetch projects from API
  Future<void> fetchProjects() async {
    isLoading.value = true;
    error.value = '';
    
    try {
      // No login check needed
      final result = await ProjetProvider.getAllProjets();
      
      if (result['success']) {
        // If API call is successful, update projects list
        final apiProjects = result['projects'] as List<dynamic>;
        
        if (apiProjects.isEmpty) {
          // If no projects, clear the list
          projects.clear();
        } else {
          // Convert API response to the format we need
          projects.value = apiProjects.map((project) {
            return {
              'title': project['titre'] ?? '',
              'ets': project['association_nom'] ?? 'قلوب محسنة',
              'done': double.parse((project['pourcentage_completion'] ?? 0).toString()),
              'details': project['description'] ?? '',
              'audiance': project['public_cible'] ?? '',
              'id': project['id'],
              'montant': project['montant'] ?? 0.0,
              'montant_recu': project['montant_recu'] ?? 0.0,
            };
          }).toList();
        }
      } else {
        // If API call fails, show error
        error.value = result['error'] ?? 'Failed to fetch projects';
        // Clear projects list instead of using mock data
        projects.clear();
      }
    } catch (e) {
      // If there's an error, show error
      error.value = 'Error fetching projects: $e';
      // Clear projects list instead of using mock data
      projects.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Get a specific project by ID
  Future<Map<String, dynamic>> getProject(int projectId) async {
    try {
      // No login check needed
      final result = await ProjetProvider.getProjet(projectId);
      
      if (result['success']) {
        final project = result['project'];
        return {
          'title': project['titre'] ?? '',
          'ets': project['association_nom'] ?? 'قلوب محسنة',
          'done': double.parse((project['pourcentage_completion'] ?? 0).toString()),
          'details': project['description'] ?? '',
          'audiance': project['public_cible'] ?? '',
          'id': project['id'],
          'montant': project['montant'] ?? 0.0,
          'montant_recu': project['montant_recu'] ?? 0.0,
        };
      } else {
        // Return error
        return {'error': result['error'] ?? 'Failed to fetch project'};
      }
    } catch (e) {
      // Return error
      return {'error': 'Error fetching project: $e'};
    }
  }

  // Create a new project
  Future<Map<String, dynamic>> createProject(Map<String, dynamic> projectData) async {
    try {
      // No login check needed
      final result = await ProjetProvider.createProjet(projectData);
      
      if (result['success']) {
        // Refresh projects list
        await fetchProjects();
        return {'success': true, 'message': result['message']};
      } else {
        return {'success': false, 'error': result['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error creating project: $e'};
    }
  }

  // Update a project
  Future<Map<String, dynamic>> updateProject(int projectId, Map<String, dynamic> projectData) async {
    try {
      // No login check needed
      final result = await ProjetProvider.updateProjet(projectId, projectData);
      
      if (result['success']) {
        // Refresh projects list
        await fetchProjects();
        return {'success': true, 'message': result['message']};
      } else {
        return {'success': false, 'error': result['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating project: $e'};
    }
  }

  // Delete a project
  Future<Map<String, dynamic>> deleteProject(int projectId) async {
    try {
      // No login check needed
      final result = await ProjetProvider.deleteProjet(projectId);
      
      if (result['success']) {
        // Refresh projects list
        await fetchProjects();
        return {'success': true, 'message': result['message']};
      } else {
        return {'success': false, 'error': result['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Error deleting project: $e'};
    }
  }
}