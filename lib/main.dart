import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/auth/auth_bloc.dart';
import 'package:portfolio/datasource/repository/respository.dart';
import 'package:portfolio/dependency.dart';
import 'package:portfolio/routes/routes.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  depen();
  setPathUrlStrategy();
  runApp(
    BlocProvider(
      create: (context) => LoginBloc(getIt<LoginRepository>()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Michaelking',
      routerConfig: router,
    );
  }
}
