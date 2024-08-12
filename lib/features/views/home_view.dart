import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/services/auth/auth_service.dart';
import 'package:twitter_clone/features/viewmodels/providers/post_provider.dart';
import 'package:twitter_clone/features/views/views.dart';
import 'package:twitter_clone/shared/components/components.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  static const name = 'home_view';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _auth = AuthService();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(postUserProvider.notifier).loadAllPost();
    });
  }

  void _logout() async {
    try {
      await _auth.logoutAuth();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _showPostMessageBox() {
    showDialog(
      context: context,
      builder: (context) => CustomInputAlertBioBox(
        controller: _messageController,
        hintText: 'Que estas pensando?',
        onPressed: () {
          if (_messageController.text.isEmpty) return;
          _postMenssage(message: _messageController.text);
        },
        onPressText: 'Postear',
      ),
    );
  }

  Future<void> _postMenssage({required String message}) async {
    await ref.read(postUserProvider.notifier).postMessage(message: message);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostMessageBox,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('I N I C I O'),
      ),
      drawer: _buildDrawer(),
      body: RefreshIndicator.adaptive(
        onRefresh: () => ref.read(postUserProvider.notifier).loadAllPost(),
        child: _buildPostList(),
      ),
    );
  }

  Widget _buildPostList() {
    return Consumer(
      builder: (_, ref, child) {
        final posts = ref.watch(postUserProvider).value ?? [];
        return posts.isEmpty
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return CustomPostTile(
                    onPostTap: () =>
                        context.push('/${PostView.name}/${post.uid}'),
                    post: post,
                    onUserTap: () =>
                        context.push('/${ProfileView.name}/${post.uid}'),
                  );
                },
              );
      },
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
              indent: 25,
              endIndent: 25,
            ),
            CustomListile(
              onTap: () {
                context.pop();
                context.push('/${HomeView.name}');
              },
              title: 'I N I C I O',
              icon: Icons.home,
            ),
            CustomListile(
              onTap: () {
                final uid = _auth.getCurrentUserUid();
                context.pop();
                context.push('/${ProfileView.name}/$uid');
              },
              title: 'P E R F I L',
              icon: Icons.person,
            ),
            CustomListile(
              onTap: () {
                context.pop();
                context.push('/${SearchView.name}');
              },
              title: 'B U S C A R',
              icon: Icons.search,
            ),
            CustomListile(
              onTap: () {
                context.pop();
                context.push('/${SettingView.name}');
              },
              title: 'A J U S T E S',
              icon: Icons.settings,
            ),
            const Spacer(),
            CustomListile(
              onTap: _logout,
              title: 'S A L I R',
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }
}
