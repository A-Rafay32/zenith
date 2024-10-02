import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/features/expedition/repository/expedition_detail_repository.dart';
import 'package:zenith/features/expedition/repository/expediton_repository.dart';

final expeditionRepositoryProvider = Provider((ref) {
  return ExpeditionRepository();
});

final expeditionDetailRepositoryProvider = Provider((ref) {
  return ExpeditionDetailRepository();
});

final expeditionStreamProvider = StreamProvider((ref) {
  final repository = ref.watch(expeditionRepositoryProvider);
  return repository.getAllExpeditions();
});

final expeditionDetailStreamProvider =
    StreamProvider.family((ref, String expeditionId) {
  final repository = ref.watch(expeditionDetailRepositoryProvider);
  return repository.getAllExpeditionDetails(expeditionId);
});
