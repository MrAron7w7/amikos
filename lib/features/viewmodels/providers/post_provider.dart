import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/features/models/post.dart';
import 'package:twitter_clone/features/services/database/database_service.dart';

part 'post_provider.g.dart';

@riverpod
class PostUser extends _$PostUser {
  final DatabaseService _db = DatabaseService();
  @override
  FutureOr<List<Post>> build() {
    return [];
  }

  // Postear mensaje
  Future<void> postMessage({required String message}) async {
    state = const AsyncValue.loading();
    try {
      await _db.postMessageInFirebase(message: message);
      await loadAllPost();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Traer los posteos
  Future<void> loadAllPost() async {
    state = const AsyncValue.loading();

    try {
      final allPosts = await _db.getAllPostFromFirebase();
      state = AsyncValue.data(allPosts);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Filtrar posts por usuario
  List<Post> filterUserPosts({required String uid}) {
    return state.value?.where((post) => post.uid == uid).toList() ?? [];
  }
}
