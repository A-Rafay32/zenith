import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/features/user_quiz.dart/repository/user_quiz_repository.dart';

final userQuizRepositoryProvider = Provider((ref) {
  return UserQuizRepository();
});
