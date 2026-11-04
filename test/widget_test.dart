import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_app/main.dart';

void main() {
  testWidgets('Academic Overview renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const AcademicOverviewApp());

    // Verify profile header
    expect(find.text('Ahmad Rizki Pratama'), findsOneWidget);
    expect(find.text('NIM: 20210101001'), findsOneWidget);
    expect(find.text('Teknik Informatika'), findsOneWidget);

    // Verify info cards
    expect(find.text('GPA'), findsOneWidget);
    expect(find.text('3.75 / 4.00'), findsOneWidget);
    expect(find.text('Credits'), findsOneWidget);
    expect(find.text('96 / 144 SKS'), findsOneWidget);
    expect(find.text('Today Schedule'), findsOneWidget);
    expect(find.text('3 Classes'), findsOneWidget);
    expect(find.text('Announcements'), findsOneWidget);
    expect(find.text('5 Unread'), findsOneWidget);

    // Verify theme toggle
    expect(find.byType(Switch), findsOneWidget);
  });
}
