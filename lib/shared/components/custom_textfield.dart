import 'package:flutter/material.dart';

/*
  Custom TextField
  --------------------------------------------

  Para usar el widget debe tener:

  - Text Controller ( Para ver que ha tipeado el usuario )
  - Hin Text ( e.g. "Contraseña" )
  - Obscure Text ( e.g. true )

 */

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        counterStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
