import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/patient/appointment/presentation/screens/schedule_screen.dart';
import 'package:doctor_hunt/apps/features/patient/appointment/presentation/widgets/schedule_body.dart';
import 'package:doctor_hunt/apps/features/patient/main/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('probe schedule', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    debugPrint('PROBE doctorById(crick) = ${doctorById('crick')?.name}');
    debugPrint('PROBE t.confirmButton = "${t.confirmButton}"');

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const ScheduleScreen(doctorId: 'crick'),
      ),
    );
    await tester.pumpAndSettle();

    debugPrint('PROBE ScheduleBody present = '
        '${find.byType(ScheduleBody).evaluate().isNotEmpty}');
    debugPrint('PROBE texts = '
        '${tester.widgetList<Text>(find.byType(Text)).map((w) => w.data).toList()}');
  });
}
