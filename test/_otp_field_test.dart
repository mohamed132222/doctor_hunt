import 'package:doctor_hunt/apps/core/widgets/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

/// Regression cover for the reported crash: with the OTP length coming from the
/// Supabase project, the row of digit boxes can be told to draw more than four.
/// Six fixed boxes overflowed the sheet and threw during layout; the field
/// (now backed by `pinput`) shrinks each box to fit the available width.
void main() {
  testWidgets('the code row fits its width at 4, 6 and 8 digits',
      (tester) async {
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    for (final length in [4, 6, 8]) {
      // A narrow phone, and the narrowest the sheet is ever laid out to.
      tester.view.physicalSize = const Size(960, 1704);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 280,
                child: OtpField(length: length, onCompleted: (_) {}),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.takeException(),
        isNull,
        reason: '$length digit boxes must not overflow a 280pt row',
      );

      // The field renders and stays inside its 280pt container.
      final field = find.byType(Pinput);
      expect(field, findsOneWidget);

      final fieldRect = tester.getRect(field);
      final rowRect = tester.getRect(find.byType(OtpField));
      expect(fieldRect.left, greaterThanOrEqualTo(rowRect.left - 0.5));
      expect(fieldRect.right, lessThanOrEqualTo(rowRect.right + 0.5));
    }
  });
}
