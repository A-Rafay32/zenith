import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/core/exceptions/exceptions.dart';
import 'package:zenith/core/extensions/snackbar_ext.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/quiz/model/quiz_session.dart';
import 'package:zenith/features/quiz/providers/quiz_session_providers.dart';
import 'package:zenith/features/quiz/repository/quiz_session_repository.dart';

class QuizSessionNotifier extends StateNotifier<AsyncValue<QuizSession?>> {
  QuizSessionNotifier({required this.quizSessionRepository})
      : super(const AsyncValue.loading());

  final QuizSessionRepository quizSessionRepository;

  void createQuizSession(QuizSession quizSession, BuildContext context) async {
    state = const AsyncValue.loading();
    final result = await quizSessionRepository
        .createQuizSession(quizSession)
        .whenComplete(() => const AsyncValue.data(null));

    result.fold((left) {
      print(left.message);
      context.showSnackBar(left.message);
    }, (right) {
      print(right.message);
      context.showSnackBar(right.message);
    });
  }

  Future<QuizSession> getQuizSession(
      String sessionId, BuildContext context) async {
    state = const AsyncValue.loading();
    return await quizSessionRepository
        .getQuizSession(sessionId)
        .whenComplete(() => const AsyncValue.data(null));

    // return result.fold((left) => left, (right) => right);
  }

  Future<void> updateQuizSession(String sessionId,
      Map<String, dynamic> updatedField, BuildContext context) async {
    state = const AsyncValue.loading();
    final result = await quizSessionRepository
        .updateQuizSession(sessionId, updatedField)
        .whenComplete(() => const AsyncValue.data(null));

    result.fold((left) {
      print(left.message);
    }, (right) {
      print(right.message);
    });
  }

  Future<void> deleteQuizSession(String sessionId, BuildContext context) async {
    state = const AsyncValue.loading();
    final result = await quizSessionRepository
        .deleteQuizSession(sessionId)
        .whenComplete(() => const AsyncValue.data(null));

    result.fold((left) {
      print(left.message);
    }, (right) {
      print(right.message);
    });
  }
}

final quizSessionNotifierProvider =
    StateNotifierProvider<QuizSessionNotifier, AsyncValue<QuizSession?>>((ref) {
  final quizSessionRepository = ref.watch(quizSessionRepositoryProvider);
  return QuizSessionNotifier(quizSessionRepository: quizSessionRepository);
});
