import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/models/user.dart';
import '/features/services/database/database_service.dart';

// Provider del usuario
final userProviderr = StateNotifierProvider<UserProvider, UserProviderState>(
  (ref) {
    return UserProvider(
      DatabaseService(),
    );
  },
);

class UserProvider extends StateNotifier<UserProviderState> {
  final DatabaseService _db;
  UserProvider(this._db) : super(UserProviderState());

  // Obtener la información del usuario actual
  Future<UserProfile?> getUserProfile({required String uid}) async {
    final user = await _db.getUserFromFirebase(uid: uid);
    state = state.copyWith(userProfile: user);
    return user;
  }

  // Actualizar la bio
  Future<void> updateBio({required String bio}) async {
    await _db.updateUserBioInFirebase(bio: bio);
    if (state.userProfile != null) {
      state = state.copyWith(
        userProfile: state.userProfile!.copyWith(bio: bio),
      );
    }
  }
}

class UserProviderState {
  final UserProfile? userProfile;

  UserProviderState({this.userProfile});

  UserProviderState copyWith({
    UserProfile? userProfile,
  }) =>
      UserProviderState(
        userProfile: userProfile ?? this.userProfile,
      );
}
