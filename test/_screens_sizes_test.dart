import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/register_screen.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/forgot_password_sheet.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/reset_password_sheet.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/verify_code_sheet.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt/apps/features/patient/appointment/presentation/screens/appointment_screen.dart';
import 'package:doctor_hunt/apps/features/patient/appointment/presentation/screens/schedule_screen.dart';
import 'package:doctor_hunt/apps/features/patient/booking/presentation/screens/booking_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/screens/book_screen.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/screens/chat_screen.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/screens/favorites_screen.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/screens/home_screen.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/home_bottom_nav.dart';
import 'package:doctor_hunt/apps/features/patient/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every user-facing surface, so a layout regression on any of them is caught.
final _screens = <String, Widget Function()>{
  // splash is excluded: it schedules a navigation Timer, which a single-frame
  // pump cannot flush (and its layout is a static logo).
  'onboarding': () => const OnboardingScreen(),
  'choose-role': () => const ChooseRoleScreen(),
  'login': () => const LoginScreen(),
  'register': () => const RegisterScreen(),
  'home': () => const HomeScreen(),
  'doctor-details': () => const DoctorDetailsScreen(doctorId: 'crick'),
  'booking': () => const BookingScreen(doctorId: 'crick'),
  'search': () => const SearchScreen(initialQuery: 'Dentist'),
  'appointment': () => const AppointmentScreen(doctorId: 'crick'),
  'schedule': () => const ScheduleScreen(doctorId: 'crick'),
  'favorites': () => const FavoritesScreen(),
  'book': () => const BookScreen(),
  'chat': () => const ChatScreen(),
  'bottom-nav': () => HomeBottomNav(currentIndex: 0, onSelect: (_) {}),
  'forgot-sheet': () => const ForgotPasswordSheet(),
  'reset-sheet': () => const ResetPasswordSheet(),
  'verify-sheet': () => const VerifyCodeSheet(email: 'user@example.com'),
};

/// Design frame, a small phone and a phone in landscape — the shapes whose
/// width and height scales diverge most.
const _shapes = [Size(375, 812), Size(320, 568), Size(800, 375)];

/// 1.0 plus enlarged system fonts (2.0 is the Android maximum).
const _textScales = [1.0, 1.4, 2.0];

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final loader = FontLoader('Rubik')
      ..addFont(rootBundle.load('assets/fonts/Rubik.ttf'));
    await loader.load();
  });

  for (final screen in _screens.entries) {
    for (final shape in _shapes) {
      for (final scale in _textScales) {
        testWidgets(
          '${screen.key} @ ${shape.width.toInt()}x${shape.height.toInt()} '
          'text x$scale',
          (tester) async {
            tester.view.physicalSize = shape * 3;
            tester.view.devicePixelRatio = 3.0;
            tester.platformDispatcher.textScaleFactorTestValue = scale;
            addTearDown(tester.view.reset);
            addTearDown(
              tester.platformDispatcher.clearTextScaleFactorTestValue,
            );

            await tester.pumpWidget(
              MaterialApp(
                theme: AppTheme.light,
                // A Scaffold guarantees the Material ancestor every screen
                // (and its text fields) expects.
                home: Scaffold(body: screen.value()),
              ),
            );
            await tester.pump();

            expect(tester.takeException(), isNull);
          },
        );
      }
    }
  }
}
