
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/trip_plan.dart';
import '../providers/trip_provider.dart';
import '../theme/app_colors.dart';

class AddItineraryScreen extends StatefulWidget {
  final String? destinationName;

  const AddItineraryScreen({
    super.key,
    this.destinationName,
  });

  @override
  State<AddItineraryScreen> createState() =>
      _AddItineraryScreenState();
}

class _AddItineraryScreenState extends State<AddItineraryScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _destinationController;
  final TextEditingController _notesController =
      TextEditingController();

  DateTime? _visitDate;

  @override
  void initState() {
    super.initState();

    _destinationController = TextEditingController(
      text: widget.destinationName ?? '',
    );
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _visitDate ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 5),
    );

    if (selectedDate != null && mounted) {
      setState(() {
        _visitDate = selectedDate;
      });
    }
  }

  Future<void> _saveItinerary() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_visitDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your travel date.'),
        ),
      );
      return;
    }

    final trip = TripPlan(
      destinationName: _destinationController.text.trim(),
      visitDate: _visitDate!,
      notes: _notesController.text.trim(),
    );

    final success =
        await context.read<TripProvider>().createTrip(trip);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Itinerary saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to save itinerary. Please check your connection and database permissions.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
        child: Form(
          key: _formKey,
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

              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  prefixIcon: Icon(Icons.place_rounded),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Destination cannot be empty.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Travel Date',
                    prefixIcon: Icon(Icons.calendar_month_rounded),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _visitDate == null
                        ? 'Select travel date'
                        : '${_visitDate!.day.toString().padLeft(2, '0')}/'
                            '${_visitDate!.month.toString().padLeft(2, '0')}/'
                            '${_visitDate!.year}',
                    style: TextStyle(
                      color: _visitDate == null
                          ? Colors.grey
                          : AppColors.dark,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  prefixIcon: Icon(Icons.notes_rounded),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),

              const Spacer(),

              Consumer<TripProvider>(
                builder: (context, provider, child) {
                  final isSaving = provider.isCreating;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          isSaving ? null : _saveItinerary,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ocean,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.ocean.withValues(alpha: 0.7),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: isSaving
                          ? const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text('Saving Itinerary...'),
                              ],
                            )
                          : const Text('Save Itinerary'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
