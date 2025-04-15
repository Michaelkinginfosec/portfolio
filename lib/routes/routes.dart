import 'package:go_router/go_router.dart';
import 'package:portfolio/pages/dashboard_page.dart';
import 'package:portfolio/pages/home_page.dart';
import 'package:portfolio/pages/login_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/portfolio',
  // initialLocation: '/login',
  // initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/portfolio',
      name: '/portfolio',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/dashboard',
      name: "/dashboard",
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/login',
      name: "/login",
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
