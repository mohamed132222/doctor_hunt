import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('Login opens the forgot-password sheet', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const LoginScreen()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Forgot password'));
    await tester.pumpAndSettle();

    expect(find.text('Forgot password'), findsWidgets);
  });
}
