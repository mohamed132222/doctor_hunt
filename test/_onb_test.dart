import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  testWidgets('Onboarding clears the bottom navigation inset', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436); // 375x812 @3x
    tester.view.devicePixelRatio = 3.0;
    // Simulate a 34pt navigation-bar inset (physical px).
    tester.view.padding = const FakeViewPadding(bottom: 34 * 3);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const OnboardingScreen()),
    );
    await tester.pumpAndSettle();

    final skipBottom = tester.getBottomLeft(find.byType(TextButton)).dy;
    // ignore: avoid_print
    print('SKIP bottom=$skipBottom  (nav inset ends at 812-34=778)');
    // The skip must sit above the navigation bar.
    expect(skipBottom, lessThanOrEqualTo(812 - 34.0));
  });
}
