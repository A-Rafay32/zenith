import 'dart:convert';

class ExpeditionDetail {
  final String id;
  final int order;
  final String text;
  final String description;
  final String? image;
  final Map<String, dynamic>? extras;

  ExpeditionDetail({
    required this.id,
    this.order = 1,
    required this.text,
    required this.description,
    this.image,
    this.extras,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'text': text,
      'description': description,
      'image': image,
      'extras': extras,
    };
  }

  factory ExpeditionDetail.fromMap(Map<String, dynamic> map) {
    return ExpeditionDetail(
      id: map['id'] ?? '',
      order: map['order']?.toInt() ?? 0,
      text: map['text'] ?? '',
      description: map['description'] ?? '',
      image: map['image'],
      extras: (map['extras']) ?? {},
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpeditionDetail.fromJson(String source) =>
      ExpeditionDetail.fromMap(json.decode(source));
}
