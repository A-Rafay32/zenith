import 'dart:convert';
import 'package:zenith/features/user_quiz.dart/model/user_answer.dart';

class QuizSession {
  final String id;
  final String quizId;
  final String userId;
  final List<UserAnswer> userAnswers;
  final int currentScore;
  final int? currentQuestionIndex;
  final int attemptCount;
  final DateTime startTime;

  QuizSession({
    required this.id,
    required this.quizId,
    required this.userId,
    required this.userAnswers,
    required this.currentScore,
    this.currentQuestionIndex = 0,
    required this.attemptCount,
    required this.startTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizId': quizId,
      'userId': userId,
      'userAnswers': userAnswers.map((x) => x.toMap()).toList(),
      'currentScore': currentScore,
      'currentQuestionIndex': currentQuestionIndex,
      'attemptCount': attemptCount,
      'startTime': startTime.millisecondsSinceEpoch,
    };
  }

  factory QuizSession.fromMap(Map<String, dynamic> map) {
    return QuizSession(
      id: map['id'] ?? '',
      quizId: map['quizId'] ?? '',
      userId: map['userId'] ?? '',
      userAnswers: List<UserAnswer>.from(
          map['userAnswers']?.map((x) => UserAnswer.fromMap(x))),
      currentScore: map['currentScore']?.toInt() ?? 0,
      currentQuestionIndex: map['currentQuestionIndex']?.toInt() ?? 0,
      attemptCount: map['attemptCount']?.toInt() ?? 0,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizSession.fromJson(String source) =>
      QuizSession.fromMap(json.decode(source));
}
