import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/app/constants/firebase_constants.dart';
import 'package:zenith/core/extensions/snackbar_ext.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/auth/providers/auth_providers.dart';
import 'package:zenith/features/expedition/model/expedition.dart';
import 'package:zenith/features/expedition/providers/expedition_provider.dart';
import 'package:zenith/features/expedition/repository/expediton_repository.dart';
import 'package:zenith/features/quiz/model/question.dart';
import 'package:zenith/features/quiz/model/quiz.dart';
import 'package:zenith/features/quiz/providers/question_providers.dart';
import 'package:zenith/features/quiz/providers/quiz_providers.dart';
import 'package:zenith/features/quiz/repository/question_repository.dart';
import 'package:zenith/features/quiz/repository/quiz_repository.dart';

class QuestionNotifier extends StateNotifier<AsyncValue> {
  QuestionNotifier({required this.questionRepository})
      : super(const AsyncValue.data(null));

  final QuestionRepository questionRepository;

  void addQuestion(
      {required Question question,
      required String? adminId,
      required String quizId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await questionRepository
        .addQuestion(question: question, adminId: adminId, quizId: quizId)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  void updateQuizById(
      {required String quizId,
      required String questionId,
      required Map<String, dynamic> updatefields,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await questionRepository
        .updateQuestionById(
          quizId,
          questionId,
          updatefields,
        )
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  void deleteQuestion(
      {required String quizId,
      required String questionId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await questionRepository
        .deleteQuestion(quizId, questionId)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  FutureEither1<Question> getQuestionById(
      {required String quizId,
      required String questionId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    return await questionRepository
        .getQuestionById(quizId, questionId)
        .whenComplete(() => const AsyncValue.data(null));
  }

  Stream<List<Question>> getAllQuestions(String quizId) {
    state = const AsyncValue.loading();
    final result = questionRepository.getAllQuestions(quizId);
    return result;
  }
}

final questionNotifier =
    StateNotifierProvider<QuestionNotifier, AsyncValue>((ref) {
  final provider = ref.watch(questionRepositoryProvider);
  return QuestionNotifier(questionRepository: provider);
});
