
class TripPlan {
  final int? id;
  final String destinationName;
  final DateTime visitDate;
  final String notes;
  final String status;
  final DateTime? createdAt;

  const TripPlan({
    this.id,
    required this.destinationName,
    required this.visitDate,
    required this.notes,
    this.status = 'Planned',
    this.createdAt,
  });

  factory TripPlan.fromJson(Map<String, dynamic> json) {
    return TripPlan(
      id: (json['id'] as num?)?.toInt(),
      destinationName:
          json['destination_name'] as String? ?? '',
      visitDate: DateTime.parse(
        json['visit_date'] as String,
      ),
      notes: json['notes'] as String? ?? '',
      status: json['status'] as String? ?? 'Planned',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destination_name': destinationName,
      'visit_date': visitDate.toIso8601String().split('T').first,
      'notes': notes,
      'status': status,
      if (createdAt != null)
        'created_at': createdAt!.toIso8601String(),
    };
  }
}
