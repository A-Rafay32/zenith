import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/features/quiz/repository/quiz_repository.dart';

final quizRepositoryProvider = Provider((ref) {
  return QuizRepository();
});
