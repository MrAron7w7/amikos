import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/services/auth/auth_service.dart';
import 'package:twitter_clone/features/views/views.dart';

import '/core/utils/utils.dart';
import '/shared/components/components.dart';

/*
  _____________
  Login Vista

  - Email
  - Contrasena 
  _____________
*/

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  static const name = 'login_view';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  // Clave para el formulario
  final _formKey = GlobalKey<FormState>();

  // acceso a los servicios
  final _auth = AuthService();

  // Funcion de inicio de sesion
  void _login() async {
    showLoadingCircle(context);
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.loginAuth(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (mounted) hideLoadingCircle(context);
      } catch (e) {
        if (mounted) hideLoadingCircle(context);
        if (e.toString().contains('invalid-credential')) {
          showSnackBar(
            context,
            text: 'Credenciales Invalidas, intenta de nuevo',
          );
        }
        debugPrint('ERROR:$e');
      }
    } else {
      hideLoadingCircle(context);
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gap(50),
                      // Logo
                      Icon(
                        Icons.lock_open_rounded,
                        size: 70,
                        color: Theme.of(context).colorScheme.primary,
                      ),

                      gap(50),

                      // Welcomeback message
                      CustomLabel(
                        text: 'Bienvenido de nuevo',
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),

                      gap(25),

                      // Email Textfield
                      CustomTextfield(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        hintText: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor introduce tu correo';
                          }
                          // Validar que el correo termine en @gmail.com
                          final emailPattern = RegExp(r'^[^@]+@gmail\.com$');
                          if (!emailPattern.hasMatch(value)) {
                            return 'El correo debe terminar en @gmail.com';
                          }
                          return null;
                        },
                      ),

                      gap(10),

                      // Password Texfield
                      CustomTextfield(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        hintText: 'Contraseña',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor introduce tu contraseña';
                          }
                          return null;
                        },
                      ),

                      gap(25),

                      // Forgot Password?
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomLabel(
                          text: '¿Olvidaste tu contraseña?',
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      gap(25),

                      // Sign in button
                      CustomElevatedButton(
                        onPressed: _login,
                        text: 'Login',
                      ),

                      gap(50),

                      // Not a member? register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomLabel(
                            text: '¿No eres miembro?',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          gap(5),
                          GestureDetector(
                            onTap: () => context.go('/${RegisterView.name}'),
                            child: CustomLabel(
                              text: 'Registrarse',
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
