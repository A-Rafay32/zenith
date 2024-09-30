import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/features/expedition/repository/expedition_detail_repository.dart';
import 'package:zenith/features/expedition/repository/expediton_repository.dart';

final expeditionProvider = Provider((ref) {
  return ExpeditionRepository();
});

final expeditionDetailProvider = Provider((ref) {
  return ExpeditionDetailRepository();
});
