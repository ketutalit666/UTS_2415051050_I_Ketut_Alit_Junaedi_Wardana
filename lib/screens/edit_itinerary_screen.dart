import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/trip_plan.dart';
import '../providers/trip_provider.dart';
import '../theme/app_colors.dart';

class EditItineraryScreen extends StatefulWidget {
  final TripPlan trip;

  const EditItineraryScreen({
    super.key,
    required this.trip,
  });

  @override
  State<EditItineraryScreen> createState() =>
      _EditItineraryScreenState();
}

class _EditItineraryScreenState
    extends State<EditItineraryScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _destinationController;
  late final TextEditingController _notesController;

  late DateTime _visitDate;
  late String _status;

  final List<String> _statuses = [
    'Planned',
    'Ongoing',
    'Completed',
  ];

  @override
  void initState() {
    super.initState();

    _destinationController = TextEditingController(
      text: widget.trip.destinationName,
    );

    _notesController = TextEditingController(
      text: widget.trip.notes,
    );

    _visitDate = widget.trip.visitDate;
    _status = widget.trip.status;
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _visitDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && mounted) {
      setState(() {
        _visitDate = selectedDate;
      });
    }
  }

  Future<void> _updateItinerary() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedTrip = TripPlan(
      id: widget.trip.id,
      destinationName: _destinationController.text.trim(),
      visitDate: _visitDate,
      notes: _notesController.text.trim(),
      status: _status,
      createdAt: widget.trip.createdAt,
    );

    final success = await context
        .read<TripProvider>()
        .updateTrip(updatedTrip);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Itinerary updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to update itinerary. Please try again.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

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
        child: Form(
          key: _formKey,
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
                  child: Text(_formatDate(_visitDate)),
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Trip Status',
                  prefixIcon: Icon(Icons.flag_rounded),
                  border: OutlineInputBorder(),
                ),
                items: _statuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _status = value;
                    });
                  }
                },
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
                  final isUpdating = provider.isUpdating;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          isUpdating ? null : _updateItinerary,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ocean,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.ocean.withValues(alpha: 0.7),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: isUpdating
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
                                Text('Updating Itinerary...'),
                              ],
                            )
                          : const Text('Update Itinerary'),
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
