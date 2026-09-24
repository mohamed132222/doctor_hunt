import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/common/auth/presentation/screens/login_screen.dart';
import '../../features/common/auth/presentation/screens/register_screen.dart';
import '../../features/common/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/common/splash/presentation/screens/splash_screen.dart';
import '../../features/patient/appointment/presentation/screens/appointment_screen.dart';
import '../../features/patient/appointment/presentation/screens/schedule_screen.dart';
import '../../features/patient/booking/presentation/screens/booking_screen.dart';
import '../../features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import '../../features/patient/main/presentation/screens/book_screen.dart';
import '../../features/patient/main/presentation/screens/chat_screen.dart';
import '../../features/patient/main/presentation/screens/favorites_screen.dart';
import '../../features/patient/main/presentation/screens/home_screen.dart';
import '../../features/patient/main/presentation/screens/main_shell.dart';
import '../../features/patient/search/presentation/screens/search_screen.dart';

part 'app_router.g.dart';

/// Central route configuration.
///
/// Routes are **typed classes**. `go_router_builder` generates
/// `app_router.g.dart` (the `part` above), which produces the `$appRoutes` tree.
/// Navigation is compile-checked — no string keys:
///
/// ```dart
/// const LoginRoute().go(context);
/// DoctorDetailsRoute(doctorId: id).push(context);
/// ```
///
/// Paths live in [RoutePath] so the URL scheme stays in one place.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.splash,
    routes: $appRoutes,
  );
}

// ── Entry / onboarding ──────────────────────────────────────────────────────

@TypedGoRoute<SplashRoute>(path: RoutePath.splash)
class SplashRoute extends GoRouteData with _$SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@TypedGoRoute<OnboardingRoute>(path: RoutePath.onboarding)
class OnboardingRoute extends GoRouteData with _$OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingScreen();
}

// ── Auth ────────────────────────────────────────────────────────────────────

@TypedGoRoute<ChooseRoleRoute>(path: RoutePath.chooseRole)
class ChooseRoleRoute extends GoRouteData with _$ChooseRoleRoute {
  const ChooseRoleRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChooseRoleScreen();
}

@TypedGoRoute<LoginRoute>(path: RoutePath.login)
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute({required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginScreen(role: role);
  }
}

@TypedGoRoute<RegisterRoute>(path: RoutePath.register)
class RegisterRoute extends GoRouteData with _$RegisterRoute {
  const RegisterRoute({required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterScreen(role: role);
  }
}

// ── Patient journey (pushed over the shell) ─────────────────────────────────

@TypedGoRoute<DoctorDetailsRoute>(path: RoutePath.doctorDetails)
class DoctorDetailsRoute extends GoRouteData with _$DoctorDetailsRoute {
  const DoctorDetailsRoute({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DoctorDetailsScreen(doctorId: doctorId);
}

@TypedGoRoute<BookingRoute>(path: RoutePath.booking)
class BookingRoute extends GoRouteData with _$BookingRoute {
  const BookingRoute({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BookingScreen(doctorId: doctorId);
}

@TypedGoRoute<SearchRoute>(path: RoutePath.search)
class SearchRoute extends GoRouteData with _$SearchRoute {
  const SearchRoute({this.q = ''});

  final String q;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SearchScreen(initialQuery: q);
}

@TypedGoRoute<AppointmentRoute>(path: RoutePath.appointment)
class AppointmentRoute extends GoRouteData with _$AppointmentRoute {
  const AppointmentRoute({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AppointmentScreen(doctorId: doctorId);
}

@TypedGoRoute<ScheduleRoute>(path: RoutePath.schedule)
class ScheduleRoute extends GoRouteData with _$ScheduleRoute {
  const ScheduleRoute({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ScheduleScreen(doctorId: doctorId);
}

// ── Bottom-nav shell ────────────────────────────────────────────────────────

@TypedStatefulShellRoute<MainShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(path: RoutePath.home),
      ],
    ),
    TypedStatefulShellBranch<FavoritesBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<FavoritesRoute>(path: RoutePath.favorites),
      ],
    ),
    TypedStatefulShellBranch<BookBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<BookRoute>(path: RoutePath.book),
      ],
    ),
    TypedStatefulShellBranch<ChatBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ChatRoute>(path: RoutePath.chat),
      ],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  static const String $restorationScopeId = 'main-shell';

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => MainShell(navigationShell: navigationShell);
}

class HomeBranchData extends StatefulShellBranchData {
  const HomeBranchData();
}

class FavoritesBranchData extends StatefulShellBranchData {
  const FavoritesBranchData();
}

class BookBranchData extends StatefulShellBranchData {
  const BookBranchData();
}

class ChatBranchData extends StatefulShellBranchData {
  const ChatBranchData();
}

class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class FavoritesRoute extends GoRouteData with _$FavoritesRoute {
  const FavoritesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FavoritesScreen();
}

class BookRoute extends GoRouteData with _$BookRoute {
  const BookRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const BookScreen();
}

class ChatRoute extends GoRouteData with _$ChatRoute {
  const ChatRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ChatScreen();
}

/// URL scheme — the single place a path string is written down.
abstract final class RoutePath {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String chooseRole = '/choose-role';
  static const String login = '/login';
  static const String register = '/register';

  static const String doctorDetails = '/doctor/:doctorId';
  static const String booking = '/booking/:doctorId';
  static const String search = '/search';
  static const String appointment = '/appointment/:doctorId';
  static const String schedule = '/appointment/:doctorId/schedule';

  static const String home = '/home';
  static const String favorites = '/favorites';
  static const String book = '/book';
  static const String chat = '/chat';
}
