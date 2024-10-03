import 'dart:convert';

class UserAnswer {
  final String questionId;
  final String userAnswer;

  UserAnswer({
    required this.questionId,
    required this.userAnswer,
  });

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'userAnswer': userAnswer,
    };
  }

  factory UserAnswer.fromMap(Map<String, dynamic> map) {
    return UserAnswer(
      questionId: map['questionId'] ?? '',
      userAnswer: map['userAnswer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAnswer.fromJson(String source) =>
      UserAnswer.fromMap(json.decode(source));
}
