import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/features/quiz/model/question.dart';
import 'package:zenith/features/quiz/providers/quiz_providers.dart';
import 'package:zenith/features/quiz/repository/question_repository.dart';
import 'package:zenith/features/quiz/repository/quiz_repository.dart';

final questionRepositoryProvider = Provider((ref) {
  return QuestionRepository();
});

final questionStreamProvider =
    StreamProvider.family((ref, String expeditionId) async* {
  final quizRepository = ref.read(quizRepositoryProvider);
  final quiz = await quizRepository.getQuizByExpeditionId(expeditionId);
  final repository = ref.watch(questionRepositoryProvider);
  yield* repository.getAllQuestions(quiz.id);
});

// final questionStreamProvider =
//     StreamProvider.family((ref, String expeditionId) async {
//   final quizRepository = ref.read(quizRepositoryProvider);
//   final quiz = await quizRepository.getQuizByExpeditionId(expeditionId);
//   final repository = ref.watch(questionRepositoryProvider);
//   return repository.getAllQuestions(quiz.id);
// });
