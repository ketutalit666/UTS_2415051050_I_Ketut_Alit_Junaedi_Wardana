
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AddItineraryScreen extends StatelessWidget {
  final String? destinationName;

  const AddItineraryScreen({
    super.key,
    this.destinationName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add Itinerary'),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Plan Your Trip',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: TextEditingController(
                text: destinationName ?? '',
              ),
              decoration: const InputDecoration(
                labelText: 'Destination',
                prefixIcon: Icon(Icons.place_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Travel Date',
                prefixIcon: Icon(Icons.calendar_month_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Notes',
                prefixIcon: Icon(Icons.notes_rounded),
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Form itinerary akan diaktifkan pada tahap CRUD.',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ocean,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Save Itinerary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
