import 'dart:convert';

class QuizSession {
  final String id;
  final String quizId;
  final String userId;
  final List<String> userAnswers;
  final int currentScore;
  final int currentQuestionIndex;
  final int attemptCount;

  QuizSession({
    required this.id,
    required this.quizId,
    required this.userId,
    required this.userAnswers,
    required this.currentScore,
    required this.currentQuestionIndex,
    required this.attemptCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizId': quizId,
      'userId': userId,
      'userAnswers': userAnswers,
      'currentScore': currentScore,
      'currentQuestionIndex': currentQuestionIndex,
      'attemptCount': attemptCount,
    };
  }

  factory QuizSession.fromMap(Map<String, dynamic> map) {
    return QuizSession(
      id: map['id'] ?? '',
      quizId: map['quizId'] ?? '',
      userId: map['userId'] ?? '',
      userAnswers: List<String>.from(map['userAnswers']),
      currentScore: map['currentScore']?.toInt() ?? 0,
      currentQuestionIndex: map['currentQuestionIndex']?.toInt() ?? 0,
      attemptCount: map['attemptCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizSession.fromJson(String source) =>
      QuizSession.fromMap(json.decode(source));
}
