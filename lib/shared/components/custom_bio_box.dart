import 'package:flutter/material.dart';

import '/shared/components/custom_label.dart';

class CustomBioBox extends StatelessWidget {
  final String text;
  const CustomBioBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: CustomLabel(
        text: text.isNotEmpty ? text : 'Sin descripción',
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
