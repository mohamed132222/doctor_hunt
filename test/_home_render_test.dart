import 'dart:io';
import 'dart:ui' as ui;

import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/main/presentation/screens/home_screen.dart';
import 'package:doctor_hunt/apps/features/main/presentation/widgets/home_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _images = [
  'assets/splash/ellipse_teal.png',
  'assets/splash/ellipse_green.png',
  'assets/images/home/category_dentist.png',
  'assets/images/home/category_cardio.png',
  'assets/images/home/category_eye.png',
  'assets/images/home/category_stomach.png',
  'assets/images/home/doctor_crick.png',
];

void main() {
  testWidgets('home render', (tester) async {
    tester.view.physicalSize = const Size(1125, 3522);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    // Widget tests skip box shadows by default; enable them so the capture
    // matches what the app actually renders.
    debugDisableShadows = false;

    final loader = FontLoader('Rubik')
      ..addFont(rootBundle.load('assets/fonts/Rubik.ttf'));
    await loader.load();

    // Material icons font, resolved from the Flutter SDK that runs the tests.
    final iconFontFile = File(
      '${File(Platform.resolvedExecutable).parent.parent.parent.path}'
      '/material_fonts/materialicons-regular.otf',
    );
    if (iconFontFile.existsSync()) {
      final iconLoader = FontLoader('MaterialIcons')
        ..addFont(
          Future.value(ByteData.view(iconFontFile.readAsBytesSync().buffer)),
        );
      await iconLoader.load();
    }

    final key = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(375, 812),
            padding: EdgeInsets.only(top: 44),
          ),
          child: RepaintBoundary(
            key: key,
            child: Scaffold(
              body: const HomeScreen(),
              bottomNavigationBar: HomeBottomNav(
                currentIndex: 0,
                onSelect: (_) {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      for (final p in _images) {
        await precacheImage(
          AssetImage(p),
          tester.element(find.byType(HomeScreen)),
        );
      }
    });
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      File(
        '.openclaw/tmp/home_render.png',
      ).writeAsBytesSync(bytes!.buffer.asUint8List());
      debugPrint('done');
    });

    // Restore inside the test body: the framework asserts painting debug
    // variables are unset before tearDowns run.
    debugDisableShadows = true;
  });
}
