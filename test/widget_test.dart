
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic MaterialApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Text('KisanYantra')));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('KisanYantra'), findsOneWidget);
  });
}
