// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/services/auth/auth_service.dart';
import 'package:twitter_clone/features/services/database/database_service.dart';
import 'package:twitter_clone/features/views/views.dart';

import '/core/core.dart';
import '/shared/components/components.dart';

/*
_______________________________________________________________
  Registro vista

  En esta vista el usuario se va a registrar o crear una cuenta
  en la cual va tener los datos de:
  - Nombre
  - Email
  - Contraseña
  - Confirmar contraseña
  _______________________________________________________________
*/

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});
  static const name = 'register_view';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  // Clave para el formulario
  final _formKey = GlobalKey<FormState>();

  // Servicios de Auth y Db
  final _auth = AuthService();
  final _db = DatabaseService();

  // Controladores
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Boton de registro
  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        // Inicializamos la reques del servicio para obtener el token
        //FirebaseNotification().initNotification();

        showLoadingCircle(context);
        try {
          await _auth.registerAuth(
            email: _emailController.text,
            password: _passwordController.text,
          );
          if (mounted) hideLoadingCircle(context);

          // Una vez registrado guardamos al usuario en la bas e de datos
          await _db.saveUserInfoInFirebase(
            name: _nameController.text,
            email: _emailController.text,
            tokenFcm: '',
          );

          // // Inicializar las notificaciones y obtener el token
          // final firebaseNotification = FirebaseNotification();
          // await firebaseNotification.initNotification();

          // // Obtener el token FCM y actualizarlo en el perfil del usuario
          // final tokenFcm = await FirebaseMessaging.instance.getToken();
          // if (tokenFcm != null) {
          //   final user = ref.read(userProvider.notifier);
          //   await user.updateTokenFcm(tokenFcm: tokenFcm);
          // }

          context.go('/${HomeView.name}');
        } catch (e) {
          if (mounted) hideLoadingCircle(context);

          if (e.toString().contains('weak-password')) {
            // Mostrar un mensaje de error en la UI
            showSnackBar(
              context,
              text: 'La contraseña debe tener al menos 6 caracteres.',
            );
          } else if (e.toString().contains('email-already-in-use')) {
            // Mostrar otro mensaje de error para email ya en uso
            showSnackBar(
              context,
              text: 'El correo electrónico ya está en uso.',
            );
          } else {
            // Mostrar un mensaje de error genérico
            showSnackBar(
              context,
              text: e.toString(),
            );
          }
        }
      } else {
        // Mensaje si las contraseñas no coinciden
        showSnackBar(
          context,
          text: 'Las contrasenas no coinciden.',
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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

                      // Creemos una cuenta para ti
                      CustomLabel(
                        text: 'Creemos una cuenta para ti!!',
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),

                      gap(25),

                      // Name Textfield
                      CustomTextfield(
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        hintText: 'Nombre',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor introduce tu nombre';
                          }

                          if (value.length < 5 || value.length > 10) {
                            return 'El nombre debe tener entre 5 y 10 caracteres';
                          }
                          return null;
                        },
                      ),

                      gap(10),

                      // Email Texfield
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
                        //obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor introduce tu contraseña';
                          }
                          return null;
                        },
                      ),

                      gap(10),

                      // ConfirmPassword Texfield
                      CustomTextfield(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _confirmPasswordController,
                        hintText: 'Confirmar contraseña',
                        //obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor introduce tu contraseña';
                          }
                          return null;
                        },
                      ),

                      gap(25),

                      // Sign in button
                      CustomElevatedButton(
                        onPressed: _register,
                        text: 'Registrarse',
                      ),

                      gap(50),

                      // ya tienes una cuenta
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomLabel(
                            text: '¿Ya tienes una cuenta?',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          gap(5),
                          GestureDetector(
                            onTap: () => context.go('/'),
                            child: CustomLabel(
                              text: 'Iniciar Sesion',
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
