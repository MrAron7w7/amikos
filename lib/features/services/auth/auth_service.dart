import 'package:firebase_auth/firebase_auth.dart';
/* 
  -------------------------------------------------------------------
  Servicio de autentificacion

  Que es lo que tendra:

  - Login
  - Registro
  - Cierre de sesion
  - Eliminar cuenta { Si es que lo vas a publicar en la PlayStore}
  -------------------------------------------------------------------
*/

class AuthService {
  // Obtenemo la instancia de firebase
  final _auth = FirebaseAuth.instance;

  // Obtener el usuario actual y su uid
  User? getCurrentUser() => _auth.currentUser;
  String getCurrentUserUid() => _auth.currentUser!.uid;

  // Login -> Email y contrasena
  Future<UserCredential> loginAuth({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Registro ->
  Future<UserCredential> registerAuth({
    required String email,
    required String password,
  }) async {
    try {
      if (password.length < 6) {
        throw Exception('La contrasena debe ser mayor a 6 caracteres');
      }
      final userCredential = _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Cerrar session
  Future<void> logoutAuth() async {
    await _auth.signOut();
  }

  // Eliminar cuenta
}
