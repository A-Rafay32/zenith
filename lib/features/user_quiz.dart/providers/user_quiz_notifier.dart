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
import 'package:zenith/features/user_quiz.dart/model/user_quiz.dart';
import 'package:zenith/features/user_quiz.dart/providers/user_quiz_provider.dart';
import 'package:zenith/features/user_quiz.dart/repository/user_quiz_repository.dart';

class UserQuizNotifier extends StateNotifier<AsyncValue> {
  UserQuizNotifier({required this.userQuizRepository})
      : super(const AsyncValue.data(null));

  final UserQuizRepository userQuizRepository;

  void addUserQuiz(
      {required UserQuiz userQuiz,
      required String? adminId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await userQuizRepository
        .addUserQuiz(userQuiz: userQuiz, adminId: adminId)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  void updateUserQuizById(
      {required String quizId,
      required Map<String, dynamic> updatefields,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await userQuizRepository
        .updateUserQuizId(quizId, updatefields)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  void deleteUserQuiz(
      {required String expeditionId, required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await userQuizRepository
        .deleteUserQuiz(expeditionId)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  FutureEither1<UserQuiz> getuserQuizById(
      {required String expeditionId, required BuildContext context}) async {
    state = const AsyncValue.loading();
    return await userQuizRepository
        .getUserQuizById(expeditionId)
        .whenComplete(() => const AsyncValue.data(null));
  }

  Stream<List<UserQuiz>> getAllUserQuizes() {
    state = const AsyncValue.loading();
    final result = userQuizRepository.getAllUserQuizes();
    return result;
  }
}

final userQuizNotifier =
    StateNotifierProvider<UserQuizNotifier, AsyncValue>((ref) {
  final provider = ref.watch(userQuizRepositoryProvider);
  return UserQuizNotifier(userQuizRepository: provider);
});
