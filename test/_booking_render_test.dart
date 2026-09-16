import 'dart:io';
import 'dart:ui' as ui;

import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/booking/presentation/screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _images = ['assets/images/home/mock2.png'];

Future<void> _capture(GlobalKey key, String name) async {
  final boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 3.0);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  File('.openclaw/tmp/$name.png').writeAsBytesSync(bytes!.buffer.asUint8List());
}

void main() {
  testWidgets('booking render', (tester) async {
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
          child: const BookingScreen(doctorId: 'crick'),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 120));

    await tester.runAsync(() async {
      for (final p in _images) {
        await precacheImage(
          AssetImage(p),
          tester.element(find.byType(BookingScreen)),
        );
      }
    });
    await tester.pump(const Duration(milliseconds: 120));

    // State 1: today has no slots.
    await tester.runAsync(() => _capture(key, 'booking_empty'));
    debugPrint('captured empty');

    // State 2: pick "Tomorrow" (the first day with slots).
    await tester.tap(find.textContaining('Tomorrow').first);
    await tester.pump(const Duration(milliseconds: 250));
    await tester.runAsync(() => _capture(key, 'booking_slots'));

    // State 3: choose two slots so the selected fills are visible.
    await tester.tap(find.text('1:00 PM').first);
    await tester.pump(const Duration(milliseconds: 150));
    await tester.tap(find.text('2:30 PM').first);
    await tester.pump(const Duration(milliseconds: 250));
    await tester.runAsync(() => _capture(key, 'booking_selected'));
    debugPrint('done');

    debugDisableShadows = true;
  });
}
