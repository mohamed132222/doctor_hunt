import 'package:doctor_hunt/apps/core/widgets/app_sheet.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/verify_code_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('diagnose overflow', (tester) async {
    tester.view.physicalSize = const Size(393 * 3.0, 852 * 3.0);
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
    await tester.pump(const Duration(seconds: 1));

    for (final ro in tester.renderObjectList<RenderObject>(
      find.byWidgetPredicate((_) => true),
    )) {
      if (ro is RenderFlex && ro.direction == Axis.horizontal) {
        double maxRight = 0;
        RenderObject? child = ro.firstChild;
        while (child != null) {
          final pd = child.parentData as FlexParentData;
          if (child is RenderBox && child.hasSize) {
            maxRight = maxRight > pd.offset.dx + child.size.width
                ? maxRight
                : pd.offset.dx + child.size.width;
          }
          child = pd.nextSibling;
        }
        if (maxRight > ro.size.width + 0.5) {
          // ignore: avoid_print
          print('OVERFLOWING FLEX: ${ro.runtimeType} '
              'size=${ro.size} childrenExtent=$maxRight');
          // ignore: avoid_print
          print('  creator: ${ro.debugCreator}');
        }
      }
    }
    expect(tester.takeException(), isNull);
  });
}
