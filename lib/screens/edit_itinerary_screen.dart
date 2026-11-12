
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class EditItineraryScreen extends StatelessWidget {
  final String destinationName;
  final String travelDate;
  final String notes;

  const EditItineraryScreen({
    super.key,
    required this.destinationName,
    this.travelDate = '',
    this.notes = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Itinerary'),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update Your Trip',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: destinationName,
              decoration: const InputDecoration(
                labelText: 'Destination',
                prefixIcon: Icon(Icons.place_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: travelDate,
              decoration: const InputDecoration(
                labelText: 'Travel Date',
                prefixIcon: Icon(Icons.calendar_month_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: notes,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
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
                        'Edit itinerary akan diaktifkan pada tahap CRUD.',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ocean,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Update Itinerary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
