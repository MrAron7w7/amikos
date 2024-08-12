import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/shared/components/components.dart';

class CustomInputAlertBioBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String onPressText;
  final void Function()? onPressed;
  const CustomInputAlertBioBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onPressText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: CustomTextfield(
        controller: controller,
        hintText: hintText,
        maxLength: 140,
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
            controller.clear();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            context.pop();
            onPressed!();
          },
          child: Text(onPressText),
        ),
      ],
    );
  }
}
