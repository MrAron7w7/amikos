import 'package:flutter/material.dart';

class CustomSwitchListtile extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;
  const CustomSwitchListtile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: SwitchListTile.adaptive(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
