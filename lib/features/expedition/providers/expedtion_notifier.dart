import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/app/constants/firebase_constants.dart';
import 'package:zenith/core/extensions/snackbar_ext.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/auth/providers/auth_providers.dart';
import 'package:zenith/features/expedition/model/expedition.dart';
import 'package:zenith/features/expedition/providers/expedition_provider.dart';
import 'package:zenith/features/expedition/repository/expediton_repository.dart';

class ExpeditionNotifier extends StateNotifier<AsyncValue> {
  ExpeditionNotifier({required this.expeditionRepository})
      : super(const AsyncValue.data(null));

  final ExpeditionRepository expeditionRepository;

  void addExpedition(
      {required Expedition expedition,
      required String? adminId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await expeditionRepository
        .addExpedition(expedition: expedition, adminId: adminId)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  void updateExpeditionById(
      {required String expeditionId,
      required Map<String, dynamic> updatefields,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await expeditionRepository
        .updateExpeditionById(expeditionId, updatefields)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  void deleteExpedition(
      {required String expeditionId, required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await expeditionRepository
        .deleteExpedition(expeditionId)
        .whenComplete(() => const AsyncValue.data(null));
    result.fold((left) => context.showSnackBar(left.message),
        (right) => context.showSnackBar(right.message));
  }

  FutureEither1<Expedition> getExpeditionById(
      {required String expeditionId, required BuildContext context}) async {
    state = const AsyncValue.loading();
    return await expeditionRepository
        .getExpeditionById(expeditionId)
        .whenComplete(() => const AsyncValue.data(null));
  }

  Stream<List<Expedition>> getAllExpeditions() {
    state = const AsyncValue.loading();
    final result = expeditionRepository.getAllExpeditions();
    return result;
  }
}

final expeditionNotifier =
    StateNotifierProvider<ExpeditionNotifier, AsyncValue>((ref) {
  final provider = ref.watch(expeditionRepositoryProvider);
  return ExpeditionNotifier(expeditionRepository: provider);
});
