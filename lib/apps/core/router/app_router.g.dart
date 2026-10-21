// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $onboardingRoute,
  $chooseRoleRoute,
  $loginRoute,
  $registerRoute,
  $doctorDetailsRoute,
  $specialtyDoctorsRoute,
  $patientAppointmentDetailsRoute,
  $bookingRoute,
  $searchRoute,
  $appointmentRoute,
  $scheduleRoute,
  $profileRoute,
  $privacyPolicyRoute,
  $patientChangePasswordRoute,
  $mainShellRoute,
  $adminShellRoute,
  $adminCreateDoctorRoute,
  $adminDoctorDetailsRoute,
  $adminEditDoctorRoute,
  $adminAvailabilityRoute,
  $adminAppointmentDetailsRoute,
  $adminProfileEditRoute,
  $adminChangePasswordRoute,
];

RouteBase get $splashRoute =>
    GoRouteData.$route(path: '/', factory: _$SplashRoute._fromState);

mixin _$SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',

  factory: _$OnboardingRoute._fromState,
);

mixin _$OnboardingRoute on GoRouteData {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chooseRoleRoute => GoRouteData.$route(
  path: '/choose-role',

  factory: _$ChooseRoleRoute._fromState,
);

mixin _$ChooseRoleRoute on GoRouteData {
  static ChooseRoleRoute _fromState(GoRouterState state) =>
      const ChooseRoleRoute();

  @override
  String get location => GoRouteData.$location('/choose-role');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: _$LoginRoute._fromState);

mixin _$LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute(
    role: _$UserRoleEnumMap._$fromName(state.uri.queryParameters['role']!)!,
  );

  LoginRoute get _self => this as LoginRoute;

  @override
  String get location => GoRouteData.$location(
    '/login',
    queryParams: {'role': _$UserRoleEnumMap[_self.role]},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

const _$UserRoleEnumMap = {
  UserRole.patient: 'patient',
  UserRole.admin: 'admin',
};

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) =>
      entries.where((element) => element.value == value).firstOrNull?.key;
}

RouteBase get $registerRoute =>
    GoRouteData.$route(path: '/register', factory: _$RegisterRoute._fromState);

mixin _$RegisterRoute on GoRouteData {
  static RegisterRoute _fromState(GoRouterState state) => RegisterRoute(
    role: _$UserRoleEnumMap._$fromName(state.uri.queryParameters['role']!)!,
  );

  RegisterRoute get _self => this as RegisterRoute;

  @override
  String get location => GoRouteData.$location(
    '/register',
    queryParams: {'role': _$UserRoleEnumMap[_self.role]},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $doctorDetailsRoute => GoRouteData.$route(
  path: '/doctor/:doctorId',

  factory: _$DoctorDetailsRoute._fromState,
);

mixin _$DoctorDetailsRoute on GoRouteData {
  static DoctorDetailsRoute _fromState(GoRouterState state) =>
      DoctorDetailsRoute(doctorId: state.pathParameters['doctorId']!);

  DoctorDetailsRoute get _self => this as DoctorDetailsRoute;

  @override
  String get location =>
      GoRouteData.$location('/doctor/${Uri.encodeComponent(_self.doctorId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $specialtyDoctorsRoute => GoRouteData.$route(
  path: '/specialty/:specialty',

  factory: _$SpecialtyDoctorsRoute._fromState,
);

mixin _$SpecialtyDoctorsRoute on GoRouteData {
  static SpecialtyDoctorsRoute _fromState(GoRouterState state) =>
      SpecialtyDoctorsRoute(specialty: state.pathParameters['specialty']!);

  SpecialtyDoctorsRoute get _self => this as SpecialtyDoctorsRoute;

  @override
  String get location => GoRouteData.$location(
    '/specialty/${Uri.encodeComponent(_self.specialty)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $patientAppointmentDetailsRoute => GoRouteData.$route(
  path: '/appointments/:appointmentId',

  factory: _$PatientAppointmentDetailsRoute._fromState,
);

mixin _$PatientAppointmentDetailsRoute on GoRouteData {
  static PatientAppointmentDetailsRoute _fromState(GoRouterState state) =>
      PatientAppointmentDetailsRoute(
        appointmentId: state.pathParameters['appointmentId']!,
      );

  PatientAppointmentDetailsRoute get _self =>
      this as PatientAppointmentDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/appointments/${Uri.encodeComponent(_self.appointmentId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $bookingRoute => GoRouteData.$route(
  path: '/booking/:doctorId',

  factory: _$BookingRoute._fromState,
);

mixin _$BookingRoute on GoRouteData {
  static BookingRoute _fromState(GoRouterState state) =>
      BookingRoute(doctorId: state.pathParameters['doctorId']!);

  BookingRoute get _self => this as BookingRoute;

  @override
  String get location =>
      GoRouteData.$location('/booking/${Uri.encodeComponent(_self.doctorId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchRoute =>
    GoRouteData.$route(path: '/search', factory: _$SearchRoute._fromState);

mixin _$SearchRoute on GoRouteData {
  static SearchRoute _fromState(GoRouterState state) =>
      SearchRoute(q: state.uri.queryParameters['q'] ?? '');

  SearchRoute get _self => this as SearchRoute;

  @override
  String get location => GoRouteData.$location(
    '/search',
    queryParams: {if (_self.q != '') 'q': _self.q},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $appointmentRoute => GoRouteData.$route(
  path: '/appointment/:doctorId',

  factory: _$AppointmentRoute._fromState,
);

mixin _$AppointmentRoute on GoRouteData {
  static AppointmentRoute _fromState(GoRouterState state) =>
      AppointmentRoute(doctorId: state.pathParameters['doctorId']!);

  AppointmentRoute get _self => this as AppointmentRoute;

  @override
  String get location => GoRouteData.$location(
    '/appointment/${Uri.encodeComponent(_self.doctorId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $scheduleRoute => GoRouteData.$route(
  path: '/appointment/:doctorId/schedule',

  factory: _$ScheduleRoute._fromState,
);

mixin _$ScheduleRoute on GoRouteData {
  static ScheduleRoute _fromState(GoRouterState state) =>
      ScheduleRoute(doctorId: state.pathParameters['doctorId']!);

  ScheduleRoute get _self => this as ScheduleRoute;

  @override
  String get location => GoRouteData.$location(
    '/appointment/${Uri.encodeComponent(_self.doctorId)}/schedule',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileRoute =>
    GoRouteData.$route(path: '/profile', factory: _$ProfileRoute._fromState);

mixin _$ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $privacyPolicyRoute => GoRouteData.$route(
  path: '/privacy-policy',

  factory: _$PrivacyPolicyRoute._fromState,
);

mixin _$PrivacyPolicyRoute on GoRouteData {
  static PrivacyPolicyRoute _fromState(GoRouterState state) =>
      const PrivacyPolicyRoute();

  @override
  String get location => GoRouteData.$location('/privacy-policy');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $patientChangePasswordRoute => GoRouteData.$route(
  path: '/change-password',

  factory: _$PatientChangePasswordRoute._fromState,
);

mixin _$PatientChangePasswordRoute on GoRouteData {
  static PatientChangePasswordRoute _fromState(GoRouterState state) =>
      const PatientChangePasswordRoute();

  @override
  String get location => GoRouteData.$location('/change-password');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
  restorationScopeId: MainShellRoute.$restorationScopeId,
  factory: $MainShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/home', factory: _$HomeRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/favorites',

          factory: _$FavoritesRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/book', factory: _$BookRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',

          factory: _$PatientSettingsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

mixin _$HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$FavoritesRoute on GoRouteData {
  static FavoritesRoute _fromState(GoRouterState state) =>
      const FavoritesRoute();

  @override
  String get location => GoRouteData.$location('/favorites');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$BookRoute on GoRouteData {
  static BookRoute _fromState(GoRouterState state) => const BookRoute();

  @override
  String get location => GoRouteData.$location('/book');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$PatientSettingsRoute on GoRouteData {
  static PatientSettingsRoute _fromState(GoRouterState state) =>
      const PatientSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminShellRoute => StatefulShellRouteData.$route(
  restorationScopeId: AdminShellRoute.$restorationScopeId,
  factory: $AdminShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/admin/doctors',

          factory: _$AdminDoctorsRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/admin/appointments',

          factory: _$AdminAppointmentsRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/admin/settings',

          factory: _$AdminSettingsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $AdminShellRouteExtension on AdminShellRoute {
  static AdminShellRoute _fromState(GoRouterState state) =>
      const AdminShellRoute();
}

mixin _$AdminDoctorsRoute on GoRouteData {
  static AdminDoctorsRoute _fromState(GoRouterState state) =>
      const AdminDoctorsRoute();

  @override
  String get location => GoRouteData.$location('/admin/doctors');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AdminAppointmentsRoute on GoRouteData {
  static AdminAppointmentsRoute _fromState(GoRouterState state) =>
      const AdminAppointmentsRoute();

  @override
  String get location => GoRouteData.$location('/admin/appointments');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AdminSettingsRoute on GoRouteData {
  static AdminSettingsRoute _fromState(GoRouterState state) =>
      const AdminSettingsRoute();

  @override
  String get location => GoRouteData.$location('/admin/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminCreateDoctorRoute => GoRouteData.$route(
  path: '/admin/create-doctor',

  factory: _$AdminCreateDoctorRoute._fromState,
);

mixin _$AdminCreateDoctorRoute on GoRouteData {
  static AdminCreateDoctorRoute _fromState(GoRouterState state) =>
      const AdminCreateDoctorRoute();

  @override
  String get location => GoRouteData.$location('/admin/create-doctor');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminDoctorDetailsRoute => GoRouteData.$route(
  path: '/admin/doctors/:doctorId',

  factory: _$AdminDoctorDetailsRoute._fromState,
);

mixin _$AdminDoctorDetailsRoute on GoRouteData {
  static AdminDoctorDetailsRoute _fromState(GoRouterState state) =>
      AdminDoctorDetailsRoute(doctorId: state.pathParameters['doctorId']!);

  AdminDoctorDetailsRoute get _self => this as AdminDoctorDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/admin/doctors/${Uri.encodeComponent(_self.doctorId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminEditDoctorRoute => GoRouteData.$route(
  path: '/admin/doctors/:doctorId/edit',

  factory: _$AdminEditDoctorRoute._fromState,
);

mixin _$AdminEditDoctorRoute on GoRouteData {
  static AdminEditDoctorRoute _fromState(GoRouterState state) =>
      AdminEditDoctorRoute(doctorId: state.pathParameters['doctorId']!);

  AdminEditDoctorRoute get _self => this as AdminEditDoctorRoute;

  @override
  String get location => GoRouteData.$location(
    '/admin/doctors/${Uri.encodeComponent(_self.doctorId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminAvailabilityRoute => GoRouteData.$route(
  path: '/admin/doctors/:doctorId/availability',

  factory: _$AdminAvailabilityRoute._fromState,
);

mixin _$AdminAvailabilityRoute on GoRouteData {
  static AdminAvailabilityRoute _fromState(GoRouterState state) =>
      AdminAvailabilityRoute(doctorId: state.pathParameters['doctorId']!);

  AdminAvailabilityRoute get _self => this as AdminAvailabilityRoute;

  @override
  String get location => GoRouteData.$location(
    '/admin/doctors/${Uri.encodeComponent(_self.doctorId)}/availability',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminAppointmentDetailsRoute => GoRouteData.$route(
  path: '/admin/appointments/:appointmentId',

  factory: _$AdminAppointmentDetailsRoute._fromState,
);

mixin _$AdminAppointmentDetailsRoute on GoRouteData {
  static AdminAppointmentDetailsRoute _fromState(GoRouterState state) =>
      AdminAppointmentDetailsRoute(
        appointmentId: state.pathParameters['appointmentId']!,
      );

  AdminAppointmentDetailsRoute get _self =>
      this as AdminAppointmentDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/admin/appointments/${Uri.encodeComponent(_self.appointmentId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminProfileEditRoute => GoRouteData.$route(
  path: '/admin/settings/profile',

  factory: _$AdminProfileEditRoute._fromState,
);

mixin _$AdminProfileEditRoute on GoRouteData {
  static AdminProfileEditRoute _fromState(GoRouterState state) =>
      const AdminProfileEditRoute();

  @override
  String get location => GoRouteData.$location('/admin/settings/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminChangePasswordRoute => GoRouteData.$route(
  path: '/admin/settings/password',

  factory: _$AdminChangePasswordRoute._fromState,
);

mixin _$AdminChangePasswordRoute on GoRouteData {
  static AdminChangePasswordRoute _fromState(GoRouterState state) =>
      const AdminChangePasswordRoute();

  @override
  String get location => GoRouteData.$location('/admin/settings/password');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
