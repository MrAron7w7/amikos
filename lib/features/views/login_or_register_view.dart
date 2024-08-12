import 'package:flutter/material.dart';
import 'package:twitter_clone/features/views/views.dart';

/*
  Vista de login o registro

  Determiar si esta logeado o registrado

*/

class LoginOrRegisterView extends StatefulWidget {
  const LoginOrRegisterView({super.key});

  @override
  State<LoginOrRegisterView> createState() => _LoginOrRegisterViewState();
}

class _LoginOrRegisterViewState extends State<LoginOrRegisterView> {
  bool showLoginView = true;

  void toggleView() {
    setState(() => showLoginView = !showLoginView);
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginView) {
      return const LoginView();
    } else {
      return const RegisterView();
    }
  }
}
