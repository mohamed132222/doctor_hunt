import 'package:doctor_hunt/apps/core/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmptyState fits a 109px box without overflowing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 109,
            child: EmptyState(
              title: 'No doctors found',
              message: 'Try a different name or specialty.',
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);

    // Title must still be reachable when space is this tight.
    expect(find.text('No doctors found'), findsOneWidget);
  });

  testWidgets('EmptyState keeps the illustration when there is room', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 500,
            child: EmptyState(
              title: 'No doctors found',
              message: 'Try a different name or specialty.',
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
  });
}
