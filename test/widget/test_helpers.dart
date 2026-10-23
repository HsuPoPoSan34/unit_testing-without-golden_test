import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/main.dart';

void setTestView(WidgetTester tester) {
  tester.view.physicalSize = const Size(375, 667);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> openHome(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.enterText(find.byKey(const Key('email')), 'learner@example.com');
  await tester.enterText(find.byKey(const Key('password')), 'password');
  await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
  await tester.pumpAndSettle();
}
