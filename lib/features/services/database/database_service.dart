import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:twitter_clone/features/models/post.dart';
import 'package:twitter_clone/features/models/user.dart';
import 'package:twitter_clone/features/services/auth/auth_service.dart';

/* 
  Servicio de base de datos

  Que requiere:

  - User
  - Post message
  - Likes
  - Comments
  - Account stuff ( report, block, delete account)
  - Search users
*/

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

/*
    Perfil de usuario

    Cuando un nuevo usuario se registra, crearemos una cuenta
    para ellos en la cual subiremos a la base de datos
*/

  Future<void> saveUserInfoInFirebase({
    required String name,
    required String email,
  }) async {
    // Obtener el uid del usuario
    String uid = _auth.currentUser!.uid;

    // Obtenemos el nombre del email
    String userName = email.split('@')[0];

    // Crear un perfil de usuario
    UserProfile userProfile = UserProfile(
      uid: uid,
      name: name,
      email: email,
      userName: userName,
      bio: '',
      tokenFcm: '', //<- aqui uso con el provider
    );

    // Convertir el perfil de usuario en un Map para poder enviar a firestore
    final userMap = userProfile.toMap();

    // Guardarlo en firestore
    await _db.collection('Users').doc(uid).set(userMap);
  }

  Future<void> updateFCMToken(String uid) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    try {
      // Obtener el token FCM
      final tokenFcm = await firebaseMessaging.getToken();

      if (tokenFcm != null) {
        // Actualizar el token FCM en Firestore
        await db.collection('Users').doc(uid).update({
          'tokenFcm': tokenFcm,
        });
        debugPrint('Token FCM actualizado correctamente para el usuario $uid');
      } else {
        debugPrint('No se pudo obtener el token FCM');
      }
    } catch (e) {
      debugPrint('Error al actualizar el token FCM: $e');
    }
  }

  /*
    Obtener informacion del usuario
   */
  Future<UserProfile?> getUserFromFirebase({required String uid}) async {
    try {
      // Obtener el usuario de firebase
      DocumentSnapshot userDoc = await _db.collection('Users').doc(uid).get();

      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }

  /*
    Update user bio
   */

  Future<void> updateUserBioInFirebase({required String bio}) async {
    String uid = AuthService().getCurrentUserUid();

    try {
      await _db.collection("Users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }

  /*
    Postear mensaje
   */

  // Postear un mensaje
  Future<void> postMessageInFirebase({required String message}) async {
    try {
      // Obtener el uid del usuario
      final uid = _auth.currentUser!.uid;

      // Obtenemos el id para obtener el usuario
      UserProfile? user = await getUserFromFirebase(uid: uid);

      // Crear un nuevo post
      Post post = Post(
        id: '', // Firebase genera el id
        uid: uid,
        name: user!.name,
        userName: user.userName,
        message: message,
        timestamp: Timestamp.now(),
        likeCount: 0,
        likeBy: [],
      );

      // Lo convertimos en Map
      Map<String, dynamic> newPostMap = post.toMap();

      // Agregar a firebase
      await _db.collection('Posts').add(newPostMap);

      QuerySnapshot usersSnapshot = await _db.collection('Users').get();

      List<UserProfile> users = usersSnapshot.docs
          .map((doc) => UserProfile.fromDocument(doc))
          .where(
              (user) => user.uid != uid) // Excluir al usuario que hizo el post
          .toList();

      // Enviar notificaciones (esto debería hacerse en el backend por seguridad)
      for (var user in users) {
        if (user.tokenFcm != null) {
          // Aquí deberías usar un servicio de backend para enviar la notificación
          // Por ahora, simularemos el envío
          print('Enviando notificación a ${user.name} (${user.tokenFcm})');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Obtener todos los posts
  Future<List<Post>> getAllPostFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _db

          // ir a la coleccion -> Post
          .collection('Posts')

          // orden cronologico
          .orderBy('timestamp', descending: true)

          // Obtiene el dato
          .get();

      // Me da la lista de los posteos
      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (e) {
      return [];
    }
  }
  // Eliminar un post

  /*
    Likes
   */

  /*
    Comentarios
   */

  /*
    Account stuff
   */

  /*
  Follow
   */
}
