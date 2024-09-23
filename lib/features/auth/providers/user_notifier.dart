import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/app/constants/firebase_constants.dart';
import 'package:zenith/core/utils/types.dart';
import 'package:zenith/features/auth/model/user.dart';
import 'package:zenith/features/auth/repositories/user_repository.dart';
import 'package:zenith/features/auth/providers/auth_providers.dart';

class UserNotifier extends StateNotifier<AsyncValue> {
  UserNotifier({required this.userService})
      : super(const AsyncValue.data(null));

  final UserRepository userService;

  FutureEither0 updateUser(
      {String? field, required Map<String, dynamic> updatedFields}) async {
    state = const AsyncValue.loading();
    return await userService
        .updateUser(docId: currentUser?.uid ?? "", updatedFields: updatedFields)
        .whenComplete(() => const AsyncValue.data(null));
  }

  FutureEither0 addToFavourites(String houseId) async {
    return await userService
        .addToFavourites(houseId)
        .whenComplete(() => getFavourites());
  }

  // FutureEither1<List<RentalHouse>> getFavourites() async {
  //   state = const AsyncValue.loading();
  //   return await userService.getUserFavourites();
  // }
}

final userNotifier = StateNotifierProvider<UserNotifier, AsyncValue>((ref) {
  final userService = ref.read(userRepositoryProvider);
  return UserNotifier(userService: userService);
});

final favouritesProvider = FutureProvider((ref) async {
  return ref.watch(userNotifier.notifier).getFavourites();
});
