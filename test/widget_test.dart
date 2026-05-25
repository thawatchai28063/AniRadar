import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fluttrt_login_register/main.dart';

void main() {
  testWidgets('shows the AniRadar tab shell', (WidgetTester tester) async {
    await tester.pumpWidget(const FluttrtAuthApp());

    expect(find.text('AniRadar'), findsOneWidget);
    expect(find.text('กำลังฉาย'), findsOneWidget);
    expect(find.text('เร็ว ๆ นี้'), findsOneWidget);
    expect(find.text('ตารางฉาย'), findsOneWidget);
    expect(find.text('ค้นหา'), findsOneWidget);
  });

  testWidgets('opens the search tab', (WidgetTester tester) async {
    await tester.pumpWidget(const FluttrtAuthApp());

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.text('ค้นหาอนิเมะ'), findsOneWidget);
    expect(find.text('พิมพ์ชื่อเรื่องที่อยากดู แล้วกดค้นหา'), findsOneWidget);
  });
}
