import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/choose_role_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/main/presentation/screens/appointments_screen.dart';
import '../../features/main/presentation/screens/chat_screen.dart';
import '../../features/main/presentation/screens/home_screen.dart';
import '../../features/main/presentation/screens/main_shell.dart';
import '../../features/main/presentation/screens/profile_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

/// Central route configuration for the app.
///
/// Route names live in [RouteName], paths in [RoutePath].
/// Navigate with `context.goNamed(RouteName.login)` or `context.pushNamed(...)`.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.splash,
    routes: [
      GoRoute(
        name: RouteName.splash,
        path: RoutePath.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteName.onboarding,
        path: RoutePath.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: RouteName.chooseRole,
        path: RoutePath.chooseRole,
        builder: (context, state) => const ChooseRoleScreen(),
      ),
      GoRoute(
        name: RouteName.login,
        path: RoutePath.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: RouteName.register,
        path: RoutePath.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // In-app tabs, hosted by a bottom navigation bar. Each branch keeps its
      // own stack so tab state survives switching.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.home,
                path: RoutePath.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.appointments,
                path: RoutePath.appointments,
                builder: (context, state) => const AppointmentsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.chat,
                path: RoutePath.chat,
                builder: (context, state) => const ChatScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.profile,
                path: RoutePath.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

abstract final class RoutePath {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String chooseRole = '/choose-role';
  static const String login = '/login';
  static const String register = '/register';

  // Bottom-nav branches.
  static const String home = '/home';
  static const String appointments = '/appointments';
  static const String chat = '/chat';
  static const String profile = '/profile';
}

abstract final class RouteName {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String chooseRole = 'choose-role';
  static const String login = 'login';
  static const String register = 'register';

  static const String home = 'home';
  static const String appointments = 'appointments';
  static const String chat = 'chat';
  static const String profile = 'profile';
}
