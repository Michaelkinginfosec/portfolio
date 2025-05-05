import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/project/project_bloc.dart';
import 'package:portfolio/bloc/project/project_event.dart';
import 'package:portfolio/bloc/project/project_state.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/datasource/models/project_models.dart';
import 'package:portfolio/widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectBloc>().add(GetAllProjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is ProjectStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProjectFailed) {
          return Center(child: Text('Failed: ${state.message}'));
        } else if (state is ProjectLoaded) {
          final workProjects =
              state.workProjects.whereType<ProjectModel>().toList();
          final hobbyProjects =
              state.hobbyProjects.whereType<ProjectModel>().toList();

          return Container(
            width: screenWidth,
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
            child: Column(
              children: [
                // Work Projects
                const Text(
                  'Work Project',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.whitePrimary,
                  ),
                ),
                const SizedBox(height: 50),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Wrap(
                    spacing: 25,
                    runSpacing: 25,
                    children:
                        workProjects
                            .map(
                              (project) => ProjectCard(projectModel: project),
                            )
                            .toList(),
                  ),
                ),

                const SizedBox(height: 80),

                // Hobby Projects
                const Text(
                  'Hobby Project',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.whitePrimary,
                  ),
                ),
                const SizedBox(height: 50),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Wrap(
                    spacing: 25,
                    runSpacing: 25,
                    children:
                        hobbyProjects
                            .map(
                              (project) => ProjectCard(projectModel: project),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox(); // default empty state
      },
    );
  }
}
