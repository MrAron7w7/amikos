import 'package:flutter/material.dart';
import 'package:twitter_clone/core/utils/utils.dart';
import 'package:twitter_clone/features/models/post.dart';
import 'package:twitter_clone/shared/components/components.dart';

class CustomPostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;
  const CustomPostTile({
    super.key,
    required this.post,
    required this.onUserTap,
    required this.onPostTap,
  });

  @override
  State<CustomPostTile> createState() => _CustomPostTileState();
}

class _CustomPostTileState extends State<CustomPostTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onUserTap,
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  gap(5),
                  // Name and username
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabel(
                        text: widget.post.name,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomLabel(
                        text:
                            '@${widget.post.userName.length > 10 ? widget.post.userName.substring(0, 10) : widget.post.userName}',
                        fontSize: 12,
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Hora  del posteo
                  CustomLabel(
                    text: widget.post.timestamp
                        .toDate()
                        .toString()
                        .substring(11, 16),
                  ),
                ],
              ),
            ),
            gap(10),
            CustomLabel(
              text: widget.post.message,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
