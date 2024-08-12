import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/models/post.dart';

class PostView extends ConsumerStatefulWidget {
  final Post post;
  const PostView({
    super.key,
    required this.post,
  });

  static const name = 'post_view';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostViewState();
}

class _PostViewState extends ConsumerState<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.message),
      ),
    );
  }
}
