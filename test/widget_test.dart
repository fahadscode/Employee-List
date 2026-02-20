import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:employee_list/main.dart';

void main() {
  testWidgets('App renders Employee List screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Employee List'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
