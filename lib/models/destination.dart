
class Destination {
  final String id;
  final String name;
  final String location;
  final String category;
  final String description;
  final double rating;
  final double latitude;
  final double longitude;
  final String imageUrl;

  const Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.description,
    required this.rating,
    required this.latitude,
    required this.longitude,
    this.imageUrl = '',
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      location: json['location'] as String? ?? '',
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'category': category,
      'description': description,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
    };
  }
}
