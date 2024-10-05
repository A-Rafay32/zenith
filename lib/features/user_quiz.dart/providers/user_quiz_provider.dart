import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/features/user_quiz.dart/repository/user_quiz_repository.dart';

final userQuizRepositoryProvider = Provider((ref) {
  return UserQuizRepository();
});

final getAllUserQuizes = StreamProvider.family((ref, String userId) {
  final provider = ref.watch(userQuizRepositoryProvider);
  return provider.getAllUserQuizesByUserId(userId);
});
