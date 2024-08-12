import 'package:flutter/material.dart';

class CustomListile extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final IconData? icon;
  final Widget? subTitle;
  final Function()? onTap;
  const CustomListile({
    super.key,
    required this.title,
    this.trailing,
    this.icon,
    this.onTap,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      subtitle: subTitle,
      trailing: trailing,
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
