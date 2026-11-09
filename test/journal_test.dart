import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/view.dart';

void main() {
  testWidgets('bundled posts display, filter, and toggle likes', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: JournalPage()));
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pumpAndSettle();
    expect(find.text('リーフィア'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'ピカチュウ');
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ListTile, 'ピカチュウ'), findsOneWidget);
    expect(find.text('リーフィア'), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
