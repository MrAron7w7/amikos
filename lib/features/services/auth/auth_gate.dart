import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/features/views/views.dart';

/* 
  -----------------------------------------------------------------

  Vista de autenticacion

  Determina si el usuario se encuentra autenticado o no

  Si no se encuentra autenticado se redirige a la vista de login

  Si se encuentra autenticado se redirige a la vista de home

  -----------------------------------------------------------------
*/

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  static const name = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
