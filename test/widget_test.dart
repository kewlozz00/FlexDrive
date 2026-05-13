import 'package:flex_drive/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app shows static car list on home screen', (tester) async {
    await tester.pumpWidget(const FlexDriveApp());

    expect(find.text('FlexDrive'), findsOneWidget);
    expect(find.text('Carsharing for everyday city trips'), findsOneWidget);
    expect(find.text('Nearby cars'), findsOneWidget);
    expect(find.text('Tesla Model 3'), findsOneWidget);
  });
}
