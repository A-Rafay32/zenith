import 'dart:convert';

import 'package:zenith/features/user_quiz.dart/model/user_answer.dart';

class UserQuiz {
  final String id;
  final String quizId;
  final List<UserAnswer> userAnswers;
  final int finalScore;
  final bool isPassed;
  final DateTime completionTime;
  final int attemptCount;

  UserQuiz({
    required this.id,
    required this.quizId,
    required this.userAnswers,
    required this.finalScore,
    required this.isPassed,
    required this.completionTime,
    required this.attemptCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizId': quizId,
      'userAnswers': userAnswers.map((x) => x.toMap()).toList(),
      'finalScore': finalScore,
      'isPassed': isPassed,
      'completionTime': completionTime.millisecondsSinceEpoch,
      'attemptCount': attemptCount,
    };
  }

  factory UserQuiz.fromMap(Map<String, dynamic> map) {
    return UserQuiz(
      id: map['id'] ?? '',
      quizId: map['quizId'] ?? '',
      userAnswers: List<UserAnswer>.from(
          map['userAnswers']?.map((x) => UserAnswer.fromMap(x))),
      finalScore: map['finalScore']?.toInt() ?? 0,
      isPassed: map['isPassed'] ?? false,
      completionTime:
          DateTime.fromMillisecondsSinceEpoch(map['completionTime']),
      attemptCount: map['attemptCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserQuiz.fromJson(String source) =>
      UserQuiz.fromMap(json.decode(source));
}
