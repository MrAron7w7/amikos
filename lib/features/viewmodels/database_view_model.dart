import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/models/post.dart';
import 'package:twitter_clone/features/models/user.dart';
import 'package:twitter_clone/features/services/database/database_service.dart';

final dataBaseViewModelProvider =
    StateNotifierProvider<DatabaseViewModel, DatabaseViewModelState>((ref) {
  final dataBaseService = DatabaseService();
  return DatabaseViewModel(dataBaseService);
});

class DatabaseViewModel extends StateNotifier<DatabaseViewModelState> {
  final DatabaseService _db;

  DatabaseViewModel(this._db) : super(DatabaseViewModelState());

  // Obtener la información del usuario actual
  Future<UserProfile?> getUserProfile({required String uid}) async {
    final user = await _db.getUserFromFirebase(uid: uid);
    state = state.copyWith(user: user);
    return user;
  }

  // Actualizar la bio
  Future<void> updateBio({required String bio}) async {
    await _db.updateUserBioInFirebase(bio: bio);
    if (state.user != null) {
      state = state.copyWith(user: state.user!.copyWith(bio: bio));
    }
  }

  // Postear mensaje
  Future<void> postMessage({required String message}) async {
    await _db.postMessageInFirebase(message: message);
    await loadAllPost();
  }

  // Traer los posteos
  Future<void> loadAllPost() async {
    final allPosts = await _db.getAllPostFromFirebase();
    state = state.copyWith(posts: allPosts);
  }
}

class DatabaseViewModelState {
  final UserProfile? user;
  final List<Post> posts;

  DatabaseViewModelState({this.user, this.posts = const []});

  DatabaseViewModelState copyWith({
    UserProfile? user,
    List<Post>? posts,
  }) =>
      DatabaseViewModelState(
        user: user ?? this.user,
        posts: posts ?? this.posts,
      );
}
