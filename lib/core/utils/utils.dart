import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Gap gap(double space) {
  return Gap(space);
}

// Mostar un dialogo de cargando
void showLoadingCircle(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Center(child: CircularProgressIndicator.adaptive()),
    ),
  );
}

// Esconder el dialogo de cargando
void hideLoadingCircle(BuildContext context) {
  Navigator.pop(context);
}

// Mostrar un SnackBar
void showSnackBar(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
