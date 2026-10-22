import 'package:doctor_hunt/apps/core/widgets/app_sheet.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/verify_code_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

/// Regression cover for the reported crash: the verify-code sheet is laid out
/// inside `AppSheet`'s `SingleChildScrollView → Column`, which gives its child
/// an unbounded height. The old hand-rolled OTP `Row` (wrapped in an
/// `Expanded` with oversized fixed boxes) threw during layout there and
/// overflowed the sheet horizontally. The current pinput-backed field plus the
/// sheet's shrink-wrapping column must lay out without exceptions at any
/// realistic phone width.
void main() {
  for (final size in [
    const Size(393, 852), // the device from the crash log
    const Size(320, 640), // narrow phone
  ]) {
    testWidgets(
      'verify-code sheet lays out without RenderFlex errors at ${size.width}x${size.height}',
      (tester) async {
        tester.view.physicalSize = size * 3.0;
        tester.view.devicePixelRatio = 3.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: AppSheet(
                  child: VerifyCodeStep(
                    email: 'user@example.com',
                    onBack: () {},
                    onContinue: (_) {},
                    onResend: () {},
                    errorMessage: 'Wrong or expired code',
                  ),
                ),
              ),
            ),
          ),
        );
        // Advance past the first frames; a plain pump keeps the resend
        // cooldown timer happy without settling it.
        await tester.pump(const Duration(seconds: 1));

        expect(
          tester.takeException(),
          isNull,
          reason:
              'the sheet must lay out at ${size.width}x${size.height} without '
              'unbounded-constraint or overflow exceptions',
        );

        // The OTP row renders and stays inside the sheet's width.
        final fieldRect = tester.getRect(find.byType(Pinput));
        expect(fieldRect.left, greaterThanOrEqualTo(0));
        expect(fieldRect.right, lessThanOrEqualTo(size.width));

        // Entering the full code exercises the submitted pin themes.
        await tester.enterText(find.byType(EditableText), '123456');
        await tester.pump(const Duration(seconds: 1));
        expect(tester.takeException(), isNull);
      },
    );
  }
}
