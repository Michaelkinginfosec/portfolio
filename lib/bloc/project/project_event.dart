import 'package:portfolio/datasource/models/project_models.dart';

abstract class ProjectEvent {}

class AddProjectEvent extends ProjectEvent {
  final ProjectModel projectModel;
  final String type;

  AddProjectEvent(this.projectModel, this.type);
}

class GetAllProjectsEvent extends ProjectEvent {}
