import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/viewmodels/providers/post_provider.dart';
import 'package:twitter_clone/features/viewmodels/providers/user_provider.dart';
import 'package:twitter_clone/features/views/views.dart';

import '/core/core.dart';
import '/features/models/user.dart';
import '/features/services/auth/auth_service.dart';
import '/shared/components/components.dart';

class ProfileView extends ConsumerStatefulWidget {
  final String uid;

  const ProfileView(this.uid, {super.key});
  static const name = 'profile_view';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  UserProfile? user;
  String currentUserId = AuthService().getCurrentUserUid();
  bool _isLoading = true;

  // Controller
  final _bioTextcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _loadUser);
  }

  Future<void> _loadUser() async {
    user =
        await ref.read(userProvider.notifier).getUserProfile(uid: widget.uid);
    setState(() {
      _isLoading = false;
    });
  }

  void _showEditBioBox() {
    showDialog(
      context: context,
      builder: (context) => CustomInputAlertBioBox(
        controller: _bioTextcontroller,
        hintText: 'Describe tu biografia',
        onPressText: 'Guardar',
        onPressed: _saveBio,
      ),
    );
  }

  Future<void> _saveBio() async {
    setState(() {
      _isLoading = true;
    });

    // Actualizar bio
    await ref
        .read(userProvider.notifier)
        .updateBio(bio: _bioTextcontroller.text);

    // Reload user
    await _loadUser();

    // Done loading
    setState(() {
      _isLoading = false;
    });
    debugPrint('Saved bio');

    //
  }

  @override
  Widget build(BuildContext context) {
    final allUserPost =
        ref.watch(postUserProvider.notifier).filterUserPosts(uid: widget.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoading ? '' : user!.name),
      ),
      body: ListView(
        children: [
          // username
          Center(
            child: CustomLabel(
              text: _isLoading ? '' : '@${user!.name}',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          gap(25),

          // Perfil
          Center(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          gap(25),

          // Numeor de posteos

          // Followers

          // Edit bio
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLabel(
                  text: 'Bio',
                  color: Theme.of(context).colorScheme.primary,
                ),
                GestureDetector(
                  onTap: _showEditBioBox,
                  child: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          gap(5),

          // bio box
          CustomBioBox(
            text: _isLoading ? '...' : user!.bio,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10),
            child: CustomLabel(
              text: 'Posteos',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          // Lista de posteos del usuario
          allUserPost.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: allUserPost.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final post = allUserPost[index];
                    return CustomPostTile(
                      onPostTap: () =>
                          context.push('/${PostView.name}/${post.uid}'),
                      post: post,
                      onUserTap: () {},
                    );
                  },
                ),
        ],
      ),
    );
  }
}
