import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/features/quiz/repository/question_repository.dart';

final questionRepositoryProvider = Provider((ref) {
  return QuestionRepository();
});
