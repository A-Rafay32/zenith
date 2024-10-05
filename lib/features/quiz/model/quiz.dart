import 'dart:convert';

class Quiz {
  final String id;
  final String expeditionId;
  final String quizName;
  final List<String> correctAnswers;
  final int passingCriteria;

  Quiz({
    required this.id,
    required this.expeditionId,
    required this.quizName,
    required this.correctAnswers,
    required this.passingCriteria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expeditionId': expeditionId,
      'quizName': quizName,
      'correctAnswers': correctAnswers,
      'passingCriteria': passingCriteria,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'] ?? '',
      expeditionId: map['expeditionId'] ?? '',
      quizName: map['quizName'] ?? '',
      correctAnswers: List<String>.from(map['correctAnswers']),
      passingCriteria: map['passingCriteria']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) => Quiz.fromMap(json.decode(source));
}
