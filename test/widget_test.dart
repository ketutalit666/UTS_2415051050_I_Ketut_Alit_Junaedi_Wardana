
import 'package:flutter_test/flutter_test.dart';
import 'package:balitrip/main.dart';

void main() {
  testWidgets('BaliTrip app displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const BaliTripApp());

    expect(
      find.textContaining('BaliTrip'),
      findsOneWidget,
    );

    expect(
      find.textContaining('Discover Bali, Plan Your Journey'),
      findsOneWidget,
    );
  });
}
