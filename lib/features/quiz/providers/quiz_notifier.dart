import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/app/constants/firebase_constants.dart';
import 'package:zenith/core/extensions/snackbar_ext.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/auth/providers/auth_providers.dart';
import 'package:zenith/features/expedition/model/expedition.dart';
import 'package:zenith/features/expedition/providers/provider.dart';
import 'package:zenith/features/expedition/repository/expediton_repository.dart';
import 'package:zenith/features/quiz/model/quiz.dart';
import 'package:zenith/features/quiz/providers/quiz_providers.dart';
import 'package:zenith/features/quiz/repository/quiz_repository.dart';

class QuizNotifier extends StateNotifier<AsyncValue> {
  QuizNotifier({required this.quizRepository})
      : super(const AsyncValue.data(null));

  final QuizRepository quizRepository;

  void addQuiz(
      {required Quiz quiz,
      required String? adminId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await quizRepository
        .addQuiz(quiz: quiz, adminId: adminId)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  void updateExpeditionById(
      {required String quizId,
      required Map<String, dynamic> updatefields,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await quizRepository
        .updateQuizId(quizId, updatefields)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  void deleteExpedition(
      {required String expeditionId, required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await quizRepository
        .deleteQuiz(expeditionId)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  FutureEither1<Quiz> getExpeditionById(
      {required String expeditionId, required BuildContext context}) async {
    state = const AsyncValue.loading();
    return await quizRepository
        .getQuizById(expeditionId)
        .whenComplete(() => const AsyncValue.data(null));
  }

  Stream<List<Quiz>> getAllQuizes() {
    state = const AsyncValue.loading();
    final result = quizRepository.getAllQuizes();
    return result;
  }
}

final quizNotifier = StateNotifierProvider<QuizNotifier, AsyncValue>((ref) {
  final provider = ref.watch(quizRepositoryProvider);
  return QuizNotifier(quizRepository: provider);
});
