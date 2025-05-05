import 'package:portfolio/datasource/models/project_models.dart';

abstract class ProjectState {}

class ProjectLoaded extends ProjectState {
  final List<ProjectModel?> hobbyProjects;
  final List<ProjectModel?> workProjects;

  ProjectLoaded({required this.hobbyProjects, required this.workProjects});
}

class ProjecStateInitial extends ProjectState {}

class ProjectStateLoading extends ProjectState {}

class ProjectAddedSuccess extends ProjectState {
  final String message;
  ProjectAddedSuccess(this.message);
}

class ProjectFailed extends ProjectState {
  final String message;
  ProjectFailed(this.message);
}
