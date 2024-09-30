import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/core/extensions/snackbar_ext.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/expedition/model/expedtion_detail.dart';
import 'package:zenith/features/expedition/providers/provider.dart';
import 'package:zenith/features/expedition/repository/expedition_detail_repository.dart';

class ExpeditionDetailNotifier extends StateNotifier<AsyncValue> {
  ExpeditionDetailNotifier({required this.expeditionDetailRepository})
      : super(const AsyncValue.data(null));

  final ExpeditionDetailRepository expeditionDetailRepository;

  void addExpeditionDetail(
      {required ExpeditionDetail expeditionDetail,
      required String expeditionId,
      required String adminId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await expeditionDetailRepository
        .addExpeditionDetail(
            expeditionDetail: expeditionDetail,
            expeditionId: expeditionId,
            adminId: adminId)
        .whenComplete(() => const AsyncValue.data(null));

    result.fold(
      (left) => context.showSnackBar(left.message),
      (right) => context.showSnackBar(right.message),
    );
  }

  // Update ExpeditionDetail by its ID (sub-collection)
  void updateExpeditionDetailById(
      {required String expeditionId,
      required String expeditionDetailId,
      required Map<String, dynamic> updateFields,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await expeditionDetailRepository
        .updateExpeditionDetailById(
            expeditionId, expeditionDetailId, updateFields)
        .whenComplete(() => const AsyncValue.data(null));

    result.fold(
      (left) => context.showSnackBar(left.message),
      (right) => context.showSnackBar(right.message),
    );
  }

  // Delete ExpeditionDetail by ID
  void deleteExpeditionDetail(
      {required String expeditionId,
      required String detailId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    final result = await expeditionDetailRepository
        .deleteExpeditionDetail(expeditionId, detailId)
        .whenComplete(() => const AsyncValue.data(null));

    result.fold(
      (left) => context.showSnackBar(left.message),
      (right) => context.showSnackBar(right.message),
    );
  }

  // Get a single ExpeditionDetail by its ID
  FutureEither1<ExpeditionDetail> getExpeditionDetailById(
      {required String expeditionId,
      required String detailId,
      required BuildContext context}) async {
    state = const AsyncValue.loading();
    return await expeditionDetailRepository
        .getExpeditionDetailById(expeditionId, detailId)
        .whenComplete(() => const AsyncValue.data(null));
  }

  // Stream of all ExpeditionDetails in the sub-collection
  Stream<List<ExpeditionDetail>> getAllExpeditionDetails(
      {required String expeditionId}) {
    state = const AsyncValue.loading();
    final result =
        expeditionDetailRepository.getAllExpeditionDetails(expeditionId);
    return result;
  }
}

// Define the provider for ExpeditionDetailNotifier
final expeditionDetailNotifier =
    StateNotifierProvider<ExpeditionDetailNotifier, AsyncValue>((ref) {
  final provider = ref.watch(expeditionDetailProvider);
  return ExpeditionDetailNotifier(expeditionDetailRepository: provider);
});
