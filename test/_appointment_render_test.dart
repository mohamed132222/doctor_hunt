import 'dart:io';
import 'dart:ui' as ui;

import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/appointment/presentation/screens/appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _images = ['assets/images/home/mock2.png'];

void main() {
  testWidgets('appointment + confirm dialog render', (tester) async {
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
        // Wrap above the Navigator so overlay routes (dialogs) are captured too.
        builder: (context, child) => RepaintBoundary(key: key, child: child!),
        home: const AppointmentScreen(doctorId: 'crick'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      for (final p in _images) {
        await precacheImage(
          AssetImage(p),
          tester.element(find.byType(AppointmentScreen)),
        );
      }
    });
    await tester.pumpAndSettle();

    // Fill the form the way a user would, then confirm.
    await tester.enterText(find.byType(TextFormField).at(0), 'mohamed');
    await tester.enterText(find.byType(TextFormField).at(1), '2001204435482');
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      File(
        '.openclaw/tmp/appt_form.png',
      ).writeAsBytesSync(bytes!.buffer.asUint8List());
    });

    // Form capture only: tapping Next now routes to the schedule step, which
    // is rendered (and confirmed) in _schedule_render_test.dart.

    debugDisableShadows = true;
  });
}
