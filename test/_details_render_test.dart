import 'dart:io';
import 'dart:ui' as ui;

import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _images = [
  'assets/images/home/feature_doctor.jpg',
  'assets/images/home/popular_doctor.jpg',
];

void main() {
  testWidgets('doctor details render', (tester) async {
    // Render at the design's width but tall enough for the whole page.
    tester.view.physicalSize = const Size(1125, 3522);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    debugDisableShadows = false;

    final loader = FontLoader('Rubik')
      ..addFont(rootBundle.load('assets/fonts/Rubik.ttf'));
    await loader.load();
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
            child: const DoctorDetailsScreen(doctorId: 'crick'),
          ),
        ),
      ),
    );
    // pump, not pumpAndSettle: the map's tiles would try to use path_provider,
    // which has no implementation in a widget test.
    await tester.pump(const Duration(milliseconds: 120));

    await tester.runAsync(() async {
      for (final p in _images) {
        await precacheImage(
          AssetImage(p),
          tester.element(find.byType(DoctorDetailsScreen)),
        );
      }
    });
    await tester.pump(const Duration(milliseconds: 120));

    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      File(
        '.openclaw/tmp/details_render.png',
      ).writeAsBytesSync(bytes!.buffer.asUint8List());
      debugPrint('done');
    });

    debugDisableShadows = true;
  });
}
