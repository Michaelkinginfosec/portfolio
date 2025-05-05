import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/bloc/auth_status/auth_status_bloc.dart';
import 'package:portfolio/bloc/auth_status/auth_status_state.dart';
import 'package:portfolio/pages/dashboard_page.dart';
import 'package:portfolio/pages/home_page.dart';
import 'package:portfolio/pages/login_page.dart';

GoRouter createRouter(AuthStatusBloc authStatusBloc) {
  return GoRouter(
    initialLocation: '/portfolio',
    refreshListenable: GoRouterRefreshBloc(authStatusBloc),
    redirect: (context, state) {
      final authStatusBloc = BlocProvider.of<AuthStatusBloc>(context);

      if (authStatusBloc.state is AuthStatusInitial) {
        return null;
      }

      final isAuthenticated = authStatusBloc.state is Auththenticated;
      final isLoggingIn = state.uri.toString() == '/login';

      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      } else {
        if (isAuthenticated && isLoggingIn) {
          return '/dashboard';
        }
        return null;
      }
    },

    routes: [
      GoRoute(
        path: '/portfolio',
        name: '/portfolio',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/login',
        name: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}

class GoRouterRefreshBloc extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshBloc(BlocBase bloc) {
    _subscription = bloc.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
