import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/models/user.dart';
import '/features/services/database/database_service.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class User extends _$User {
  late final DatabaseService _db = DatabaseService();
  @override
  FutureOr<UserProfile?> build() => null;

  // Obtenemos el perfil del usuario
  Future<UserProfile?> getUserProfile({required String uid}) async {
    state = const AsyncValue.loading();
    try {
      final user = await _db.getUserFromFirebase(uid: uid);
      state = AsyncValue.data(user);
      return user;
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
    return null;
  }

  // Actualizamos su biografia del usuari
  Future<void> updateBio({required String bio}) async {
    state = const AsyncValue.loading();

    try {
      await _db.updateUserBioInFirebase(bio: bio);
      state = AsyncValue.data(state.value!.copyWith(bio: bio));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
