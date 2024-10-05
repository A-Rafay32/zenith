import 'dart:convert';

enum QuestionType {
  trueFalse,
  multipleChoice,
  singleChoice;

  static QuestionType toQuestionType(String str) {
    return QuestionType.values.firstWhere((element) => element.name == str);
  }
}

class Question {
  final String id;
  final String questionText;
  final String correctAnswer;
  final QuestionType questionType;
  final List<String> options;
  final int marks;
  final int order;

  Question({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.correctAnswer,
    required this.options,
    this.marks = 1,
    this.order = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'correctAnswer': correctAnswer,
      'questionType': questionType.name.toString(),
      'options': options,
      'marks': marks,
      'order': order,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] ?? '',
      questionText: map['questionText'] ?? '',
      correctAnswer: map['correctAnswer'] ?? '',
      marks: map['marks'] ?? '',
      order: map['order'] ?? 1,
      questionType: QuestionType.toQuestionType(map['questionType']),
      options: List<String>.from(map['options']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
