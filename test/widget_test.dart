
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:balitrip/providers/destination_provider.dart';
import 'package:balitrip/repositories/destination_repository.dart';
import 'package:balitrip/screens/home_screen.dart';

void main() {
  testWidgets('BaliTrip app displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => DestinationProvider(
          DestinationRepository(),
        ),
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Discover Bali'), findsOneWidget);
  });
}
