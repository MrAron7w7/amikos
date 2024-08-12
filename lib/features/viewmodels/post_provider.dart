import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/models/post.dart';
import '/features/services/database/database_service.dart';

// Provider de los posteos
final postProviderr =
    StateNotifierProvider<PostProvider, PostProviderState>((ref) {
  final dataBaseService = DatabaseService();
  return PostProvider(dataBaseService);
});

class PostProvider extends StateNotifier<PostProviderState> {
  final DatabaseService _db;
  PostProvider(this._db) : super(PostProviderState()) {
    loadAllPost();
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

  // Me retornas los post enviandos en la UI
  List<Post> filterUserPost({required String ui}) {
    return state.posts.where((post) => post.uid == ui).toList();
  }
}

class PostProviderState {
  final List<Post> posts;

  PostProviderState({this.posts = const []});

  PostProviderState copyWith({
    List<Post>? posts,
  }) =>
      PostProviderState(
        posts: posts ?? this.posts,
      );
}
