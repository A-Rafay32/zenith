import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/features/quiz/repository/quiz_session_repository.dart';

final quizSessionRepositoryProvider = Provider((ref) {
  return QuizSessionRepository();
});





