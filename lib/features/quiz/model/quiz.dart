import 'dart:convert';


class Quiz {
  final String id;
  final String expeditionId;
  final List<String> correctAnswers;
  final int passingCriteria;

  Quiz({
    required this.id,
    required this.expeditionId,
    required this.correctAnswers,
    required this.passingCriteria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expeditionId': expeditionId,
      'correctAnswers': correctAnswers,
      'passingCriteria': passingCriteria,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'] ?? '',
      expeditionId: map['expeditionId'] ?? '',
      correctAnswers: List<String>.from(map['correctAnswers']),
      passingCriteria: map['passingCriteria']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) => Quiz.fromMap(json.decode(source));
}
