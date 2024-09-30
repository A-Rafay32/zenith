import 'dart:convert';

class ExpeditionDetail {
  final String id;
  final String text;
  final String description;
  final String image;
  final Map<String, dynamic> extras;

  ExpeditionDetail({
    required this.id,
    required this.text,
    required this.description,
    required this.image,
    required this.extras,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'description': description,
      'image': image,
      'extras': extras,
    };
  }

  factory ExpeditionDetail.fromMap(Map<String, dynamic> map) {
    return ExpeditionDetail(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      extras: Map<String, dynamic>.from(map['extras']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpeditionDetail.fromJson(String source) =>
      ExpeditionDetail.fromMap(json.decode(source));
}
