import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/services/auth/auth_service.dart';

import '/features/models/user.dart';
import '/features/services/database/database_service.dart';

// Provider del usuario
final userProvider = StateNotifierProvider<UserProvider, UserProviderState>(
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

  // Actualizar el token FCM
  Future<void> updateTokenFcm({required String tokenFcm}) async {
    final uid = AuthService().getCurrentUserUid();
    await _db.updateFCMToken(uid, tokenFcm);

    if (state.userProfile != null) {
      state = state.copyWith(
        userProfile: state.userProfile!.copyWith(tokenFcm: tokenFcm),
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
