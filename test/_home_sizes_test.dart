import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device shapes the home must survive. Mixed width/height scaling used to
/// overflow the fixed-size cards on short/wide viewports (landscape, tablets).
const _sizes = [
  Size(375, 812), // design frame
  Size(390, 844), // iPhone 14
  Size(412, 915), // Pixel 7
  Size(320, 568), // small phone
  Size(800, 1280), // tablet portrait
  Size(800, 375), // phone landscape
  Size(1024, 600), // desktop-ish window
];

/// 1.0 plus enlarged system fonts — the usual real-device overflow triggers.
/// 2.0 is the Android maximum.
const _textScales = [1.0, 1.4, 2.0];

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final loader = FontLoader('Rubik')
      ..addFont(rootBundle.load('assets/fonts/Rubik.ttf'));
    await loader.load();
  });

  for (final size in _sizes) {
    for (final scale in _textScales) {
      testWidgets(
        'home has no overflow at ${size.width.toInt()}x${size.height.toInt()} '
        'text x$scale',
        (tester) async {
          tester.view.physicalSize = size * 3;
          tester.view.devicePixelRatio = 3.0;
          tester.platformDispatcher.textScaleFactorTestValue = scale;
          addTearDown(tester.view.reset);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

          await tester.pumpWidget(
            MaterialApp(
              theme: AppTheme.light,
              home: const Scaffold(body: HomeScreen()),
            ),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
