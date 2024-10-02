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
  final QuestionType questionType;
  final List<String> options;
  final int marks;

  Question({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.options,
    this.marks = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'questionType': questionType.name.toString(),
      'options': options,
      'marks': marks,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] ?? '',
      questionText: map['questionText'] ?? '',
      marks: map['marks'] ?? '',
      questionType: QuestionType.toQuestionType(map['questionType']),
      options: List<String>.from(map['options']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
