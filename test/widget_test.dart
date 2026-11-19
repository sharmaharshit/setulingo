import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setulingo/main_v2.dart';

void main() {
  testWidgets('SetuLingo app root renders', (tester) async {
    await tester.pumpWidget(const SetuLingoV2App());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
