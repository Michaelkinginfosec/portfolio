import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/bloc/auth_status/auth_status_bloc.dart';
import 'package:portfolio/bloc/auth_status/auth_status_event.dart';
import 'package:portfolio/bloc/auth_status/auth_status_state.dart';
import 'package:portfolio/bloc/project/project_bloc.dart';
import 'package:portfolio/bloc/project/project_state.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/widgets/project_dialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isLoading = false;

  void _showAddProjectDialog() {
    showDialog(context: context, builder: (context) => const ProjectDialog());
  }

  void _logout() {
    context.read<AuthStatusBloc>().add(Logout());
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectStateLoading) {
          setState(() => isLoading = true);
        } else {
          setState(() => isLoading = false);
        }

        if (state is ProjectAddedSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is ProjectFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: BlocListener<AuthStatusBloc, AuthStatusState>(
        listener: (context, authState) {
          // Handle redirect after logging out
          if (authState is Unauthenticated) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: CustomColor.scaffoldBg,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    constraints: BoxConstraints(
                      maxWidth:
                          MediaQuery.of(context).size.width < 600 ? 350 : 600,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColor.bgLight2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Admin Dashboard',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.add,
                              color: CustomColor.whitePrimary,
                            ),
                            label: const Text(
                              'Add Project',
                              style: TextStyle(color: CustomColor.whitePrimary),
                            ),
                            onPressed: _showAddProjectDialog,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: CustomColor.bgLight1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.exit_to_app,
                              color: CustomColor.whitePrimary,
                            ),
                            label: const Text(
                              'Logout',
                              style: TextStyle(color: CustomColor.whitePrimary),
                            ),
                            onPressed: _logout,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: CustomColor.bgLight1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.yellowPrimary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
