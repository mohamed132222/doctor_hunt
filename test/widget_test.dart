import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt/apps/features/common/splash/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('Splash shows then redirects to onboarding', (tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: AppRouter.router));

    // Splash is shown first.
    expect(find.byType(SplashScreen), findsOneWidget);

    // Advance past the 2s bootstrap delay.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
