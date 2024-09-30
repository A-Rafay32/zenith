import 'dart:convert';

class Expedition {
  final String id;
  final String name;
  final String description;
  final String image;

  Expedition({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  factory Expedition.fromMap(Map<String, dynamic> map) {
    return Expedition(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Expedition.fromJson(String source) =>
      Expedition.fromMap(json.decode(source));
}
