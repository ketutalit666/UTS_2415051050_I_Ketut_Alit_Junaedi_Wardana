
import 'package:flutter_test/flutter_test.dart';
import 'package:balitrip/main.dart';
import 'package:balitrip/screens/home_screen.dart';

void main() {
  testWidgets('BaliTrip app displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const BaliTripApp());

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Discover Bali'), findsOneWidget);
  });
}
