import 'dart:io';
import 'dart:ui' as ui;

import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/patient/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('search render', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
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
        home: RepaintBoundary(
          key: key,
          child: const SearchScreen(initialQuery: 'Dentist'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      await precacheImage(
        const AssetImage('assets/images/home/mock2.png'),
        tester.element(find.byType(SearchScreen)),
      );
    });
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      File(
        '.openclaw/tmp/search_render.png',
      ).writeAsBytesSync(bytes!.buffer.asUint8List());
      debugPrint('done');
    });

    debugDisableShadows = true;
  });
}
