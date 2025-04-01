import 'package:agent/src/features/authentication/ui/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static const String home = '/';
  static const String login = '/login';
}

GoRouter routes = GoRouter(
  initialLocation: AppRoute.login,
  routes: [
    GoRoute(
      name: AppRoute.login,
      path: AppRoute.login,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
