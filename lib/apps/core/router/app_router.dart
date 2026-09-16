import 'package:go_router/go_router.dart';

import '../../features/appointment/presentation/screens/appointment_screen.dart';
import '../../features/appointment/presentation/screens/schedule_screen.dart';
import '../../features/auth/presentation/screens/choose_role_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/booking/presentation/screens/booking_screen.dart';
import '../../features/doctor_details/presentation/screens/doctor_details_screen.dart';
import '../../features/main/presentation/screens/book_screen.dart';
import '../../features/main/presentation/screens/chat_screen.dart';
import '../../features/main/presentation/screens/favorites_screen.dart';
import '../../features/main/presentation/screens/home_screen.dart';
import '../../features/main/presentation/screens/main_shell.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
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

      // Full-screen detail page, pushed over the shell (no bottom nav).
      GoRoute(
        name: RouteName.doctorDetails,
        path: RoutePath.doctorDetails,
        builder: (context, state) => DoctorDetailsScreen(
          doctorId: state.pathParameters['doctorId'] ?? '',
        ),
      ),
      GoRoute(
        name: RouteName.booking,
        path: RoutePath.booking,
        builder: (context, state) =>
            BookingScreen(doctorId: state.pathParameters['doctorId'] ?? ''),
      ),
      GoRoute(
        name: RouteName.search,
        path: RoutePath.search,
        builder: (context, state) =>
            SearchScreen(initialQuery: state.uri.queryParameters['q'] ?? ''),
      ),
      GoRoute(
        name: RouteName.appointment,
        path: RoutePath.appointment,
        builder: (context, state) =>
            AppointmentScreen(doctorId: state.pathParameters['doctorId'] ?? ''),
      ),
      GoRoute(
        name: RouteName.schedule,
        path: RoutePath.schedule,
        builder: (context, state) =>
            ScheduleScreen(doctorId: state.pathParameters['doctorId'] ?? ''),
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
                name: RouteName.favorites,
                path: RoutePath.favorites,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.book,
                path: RoutePath.book,
                builder: (context, state) => const BookScreen(),
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

  /// Doctor details, deep-linkable by doctor slug.
  static const String doctorDetails = '/doctor/:doctorId';

  /// Booking page for a doctor, deep-linkable by slug.
  static const String booking = '/booking/:doctorId';

  /// Doctor search; the query is optional (`/search?q=dentist`).
  static const String search = '/search';

  /// Appointment details for a doctor, deep-linkable by slug.
  static const String appointment = '/appointment/:doctorId';

  /// Date / time / reminder step, deep-linkable by slug.
  static const String schedule = '/appointment/:doctorId/schedule';

  // Bottom-nav branches.
  static const String home = '/home';
  static const String favorites = '/favorites';
  static const String book = '/book';
  static const String chat = '/chat';
}

abstract final class RouteName {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String chooseRole = 'choose-role';
  static const String login = 'login';
  static const String register = 'register';

  static const String doctorDetails = 'doctor-details';
  static const String booking = 'booking';
  static const String search = 'search';
  static const String appointment = 'appointment';
  static const String schedule = 'schedule';

  static const String home = 'home';
  static const String favorites = 'favorites';
  static const String book = 'book';
  static const String chat = 'chat';
}
