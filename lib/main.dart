import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/auth/auth_bloc.dart';
import 'package:portfolio/bloc/auth_status/auth_status_bloc.dart';
import 'package:portfolio/bloc/contact/contact_bloc.dart';
import 'package:portfolio/bloc/project/project_bloc.dart';
import 'package:portfolio/datasource/repository/project_repository.dart';
import 'package:portfolio/datasource/repository/respository.dart';
import 'package:portfolio/dependency.dart';
import 'package:portfolio/routes/routes.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  depen();
  setPathUrlStrategy();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(getIt<LoginRepository>())),
        BlocProvider(
          create: (context) => ContactBloc(getIt<LoginRepository>()),
        ),
        BlocProvider(
          create: (context) => ProjectBloc(getIt<ProjectRepository>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  AuthStatusBloc(loginRepository: getIt<LoginRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authStatusBloc = BlocProvider.of<AuthStatusBloc>(context);
    final router = createRouter(authStatusBloc);

    return MaterialApp.router(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Michaelking',
      routerConfig: router,
    );
  }
}
