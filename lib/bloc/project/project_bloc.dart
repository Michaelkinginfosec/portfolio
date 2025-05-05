import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/project/project_event.dart';
import 'package:portfolio/bloc/project/project_state.dart';
import 'package:portfolio/datasource/repository/project_repository.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository repository;

  ProjectBloc(this.repository) : super(ProjecStateInitial()) {
    on<AddProjectEvent>((event, emit) async {
      emit(ProjectStateLoading());
      try {
        final message = await repository.addProject(
          event.type,
          event.projectModel,
        );
        emit(ProjectAddedSuccess(message));
      } catch (e) {
        emit(ProjectFailed(e.toString()));
      }
    });

    on<GetAllProjectsEvent>((event, emit) async {
      emit(ProjectStateLoading());
      try {
        final hobbyProjects = await repository.getAllProject('hobby');
        final workProjects = await repository.getAllProject('work');

        emit(
          ProjectLoaded(
            hobbyProjects: hobbyProjects,
            workProjects: workProjects,
          ),
        );
      } catch (e) {
        emit(ProjectFailed(e.toString()));
      }
    });
  }
}
