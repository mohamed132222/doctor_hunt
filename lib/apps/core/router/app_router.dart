import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role_model.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import '../../features/patient/main/presentation/controllers/favorites/favorites_cubit.dart';

import '../../features/common/auth/presentation/screens/login_screen.dart';
import '../../features/common/auth/presentation/screens/register_screen.dart';
import '../../features/common/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/common/splash/presentation/screens/splash_screen.dart';
import '../../features/patient/appointment/presentation/screens/appointment_screen.dart';
import '../../features/patient/appointment/presentation/screens/schedule_screen.dart';
import '../../features/patient/booking/presentation/screens/booking_screen.dart';
import '../../features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import '../../features/patient/main/presentation/screens/book_screen.dart';
import '../../features/patient/main/presentation/screens/favorites_screen.dart';
import '../../features/patient/main/presentation/screens/home_screen.dart';
import '../../features/patient/main/presentation/screens/main_shell.dart';
import '../../features/patient/main/presentation/screens/patient_settings_screen.dart';
import '../../features/patient/profile/presentation/screens/patient_profile_screen.dart';
import '../../features/common/privacy/presentation/screens/privacy_policy_screen.dart';
import '../../features/patient/search/presentation/screens/search_screen.dart';
import '../../features/common/doctors/data/models/doctor_specialty.dart';
import '../../features/patient/specialty/presentation/controllers/specialty_doctors/specialty_doctors_cubit.dart';
import '../../features/patient/specialty/presentation/screens/specialty_doctors_screen.dart';
import '../../features/patient/appointment/presentation/controllers/patient_appointment_details/patient_appointment_details_cubit.dart';
import '../../features/patient/appointment/presentation/screens/patient_appointment_details_screen.dart';
import '../../features/admin/main/presentation/screens/admin_shell.dart';
import '../../features/admin/doctors/presentation/screens/doctors_screen.dart';
import '../../features/admin/doctors/presentation/screens/create_doctor_screen.dart';
import '../../features/admin/doctors/presentation/screens/doctor_details_screen.dart';
import '../../features/admin/doctors/presentation/screens/edit_doctor_screen.dart';
import '../../features/admin/doctors/presentation/screens/doctor_availability_screen.dart';
import '../../features/admin/appointments/presentation/screens/admin_appointments_screen.dart';
import '../../features/admin/appointments/presentation/screens/appointment_details_screen.dart';
import '../../features/admin/settings/presentation/screens/admin_settings_screen.dart';
import '../../features/admin/settings/presentation/screens/admin_profile_edit_screen.dart';
import '../../features/admin/settings/presentation/screens/change_password_screen.dart';

part 'app_router.g.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.splash,
    routes: $appRoutes,
  );
}

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

@TypedGoRoute<DoctorDetailsRoute>(path: RoutePath.doctorDetails)
class DoctorDetailsRoute extends GoRouteData with _$DoctorDetailsRoute {
  const DoctorDetailsRoute({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<FavoritesCubit>.value(
        value: getIt<FavoritesCubit>(),
        child: DoctorDetailsScreen(doctorId: doctorId),
      );
}

@TypedGoRoute<SpecialtyDoctorsRoute>(path: RoutePath.specialtyDoctors)
class SpecialtyDoctorsRoute extends GoRouteData with _$SpecialtyDoctorsRoute {
  const SpecialtyDoctorsRoute({required this.specialty});

  final String specialty;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final parsed =
        DoctorSpecialty.fromWire(specialty) ?? DoctorSpecialty.dentist;
    return BlocProvider<SpecialtyDoctorsCubit>(
      create: (_) => getIt<SpecialtyDoctorsCubit>(param1: parsed)..load(),
      child: SpecialtyDoctorsScreen(specialty: parsed),
    );
  }
}

@TypedGoRoute<PatientAppointmentDetailsRoute>(
  path: RoutePath.patientAppointmentDetails,
)
class PatientAppointmentDetailsRoute extends GoRouteData
    with _$PatientAppointmentDetailsRoute {
  const PatientAppointmentDetailsRoute({required this.appointmentId});

  final String appointmentId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<PatientAppointmentDetailsCubit>(
        create: (_) =>
            getIt<PatientAppointmentDetailsCubit>()..load(appointmentId),
        child: PatientAppointmentDetailsScreen(appointmentId: appointmentId),
      );
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
      BlocProvider<FavoritesCubit>.value(
        value: getIt<FavoritesCubit>(),
        child: SearchScreen(initialQuery: q),
      );
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

@TypedGoRoute<ProfileRoute>(path: RoutePath.profile)
class ProfileRoute extends GoRouteData with _$ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PatientProfileScreen();
}

@TypedGoRoute<PrivacyPolicyRoute>(path: RoutePath.privacyPolicy)
class PrivacyPolicyRoute extends GoRouteData with _$PrivacyPolicyRoute {
  const PrivacyPolicyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PrivacyPolicyScreen();
}

@TypedGoRoute<PatientChangePasswordRoute>(path: RoutePath.patientChangePassword)
class PatientChangePasswordRoute extends GoRouteData
    with _$PatientChangePasswordRoute {
  const PatientChangePasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChangePasswordScreen();
}

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
    TypedStatefulShellBranch<PatientSettingsBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PatientSettingsRoute>(path: RoutePath.patientSettings),
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

class PatientSettingsBranchData extends StatefulShellBranchData {
  const PatientSettingsBranchData();
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

class PatientSettingsRoute extends GoRouteData with _$PatientSettingsRoute {
  const PatientSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PatientSettingsScreen();
}

@TypedStatefulShellRoute<AdminShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<AdminDoctorsBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminDoctorsRoute>(path: RoutePath.adminDoctors),
      ],
    ),
    TypedStatefulShellBranch<AdminAppointmentsBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminAppointmentsRoute>(path: RoutePath.adminAppointments),
      ],
    ),
    TypedStatefulShellBranch<AdminSettingsBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AdminSettingsRoute>(path: RoutePath.adminSettings),
      ],
    ),
  ],
)
class AdminShellRoute extends StatefulShellRouteData {
  const AdminShellRoute();

  static const String $restorationScopeId = 'admin-shell';

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => AdminShell(navigationShell: navigationShell);
}

class AdminDoctorsBranchData extends StatefulShellBranchData {
  const AdminDoctorsBranchData();
}

class AdminAppointmentsBranchData extends StatefulShellBranchData {
  const AdminAppointmentsBranchData();
}

class AdminSettingsBranchData extends StatefulShellBranchData {
  const AdminSettingsBranchData();
}

class AdminDoctorsRoute extends GoRouteData with _$AdminDoctorsRoute {
  const AdminDoctorsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DoctorsScreen();
}

class AdminAppointmentsRoute extends GoRouteData with _$AdminAppointmentsRoute {
  const AdminAppointmentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AdminAppointmentsScreen();
}

class AdminSettingsRoute extends GoRouteData with _$AdminSettingsRoute {
  const AdminSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AdminSettingsScreen();
}

@TypedGoRoute<AdminCreateDoctorRoute>(path: RoutePath.adminCreateDoctor)
class AdminCreateDoctorRoute extends GoRouteData with _$AdminCreateDoctorRoute {
  const AdminCreateDoctorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreateDoctorScreen();
}

@TypedGoRoute<AdminDoctorDetailsRoute>(path: RoutePath.adminDoctorDetails)
class AdminDoctorDetailsRoute extends GoRouteData
    with _$AdminDoctorDetailsRoute {
  const AdminDoctorDetailsRoute({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AdminDoctorDetailsScreen(doctorId: doctorId);
}

@TypedGoRoute<AdminEditDoctorRoute>(path: RoutePath.adminEditDoctor)
class AdminEditDoctorRoute extends GoRouteData with _$AdminEditDoctorRoute {
  const AdminEditDoctorRoute({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EditDoctorScreen(doctorId: doctorId);
}

@TypedGoRoute<AdminAvailabilityRoute>(path: RoutePath.adminAvailability)
class AdminAvailabilityRoute extends GoRouteData with _$AdminAvailabilityRoute {
  const AdminAvailabilityRoute({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DoctorAvailabilityScreen(doctorId: doctorId);
}

@TypedGoRoute<AdminAppointmentDetailsRoute>(
  path: RoutePath.adminAppointmentDetails,
)
class AdminAppointmentDetailsRoute extends GoRouteData
    with _$AdminAppointmentDetailsRoute {
  const AdminAppointmentDetailsRoute({required this.appointmentId});

  final String appointmentId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AppointmentDetailsScreen(appointmentId: appointmentId);
}

@TypedGoRoute<AdminProfileEditRoute>(path: RoutePath.adminProfileEdit)
class AdminProfileEditRoute extends GoRouteData with _$AdminProfileEditRoute {
  const AdminProfileEditRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AdminProfileEditScreen();
}

@TypedGoRoute<AdminChangePasswordRoute>(path: RoutePath.adminChangePassword)
class AdminChangePasswordRoute extends GoRouteData
    with _$AdminChangePasswordRoute {
  const AdminChangePasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChangePasswordScreen();
}

abstract final class RoutePath {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String chooseRole = '/choose-role';
  static const String login = '/login';
  static const String register = '/register';

  static const String doctorDetails = '/doctor/:doctorId';
  static const String booking = '/booking/:doctorId';
  static const String search = '/search';
  static const String specialtyDoctors = '/specialty/:specialty';
  static const String patientAppointmentDetails =
      '/appointments/:appointmentId';
  static const String appointment = '/appointment/:doctorId';
  static const String schedule = '/appointment/:doctorId/schedule';

  static const String home = '/home';
  static const String favorites = '/favorites';
  static const String book = '/book';
  static const String patientSettings = '/settings';

  static const String profile = '/profile';
  static const String privacyPolicy = '/privacy-policy';
  static const String patientChangePassword = '/change-password';

  static const String adminDoctors = '/admin/doctors';
  static const String adminAppointments = '/admin/appointments';
  static const String adminSettings = '/admin/settings';

  static const String adminCreateDoctor = '/admin/create-doctor';
  static const String adminDoctorDetails = '/admin/doctors/:doctorId';
  static const String adminEditDoctor = '/admin/doctors/:doctorId/edit';
  static const String adminAvailability =
      '/admin/doctors/:doctorId/availability';
  static const String adminAppointmentDetails =
      '/admin/appointments/:appointmentId';
  static const String adminProfileEdit = '/admin/settings/profile';
  static const String adminChangePassword = '/admin/settings/password';
}
