import 'package:portfolio/datasource/models/project_models.dart';

abstract class ProjectRepository {
  Future<String> addProject(String type, ProjectModel projectModel);
  Future<List<ProjectModel?>> getAllProject(String type);
}
