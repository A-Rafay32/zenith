import 'dart:convert';

class Question {
  final String id;
  final String questionText;
  final String questionType; // trueFalse, multiple choice, single choice
  final List<String> options;

  Question({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'questionType': questionType,
      'options': options,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] ?? '',
      questionText: map['questionText'] ?? '',
      questionType: map['questionType'] ?? '',
      options: List<String>.from(map['options']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
