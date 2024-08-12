import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotification {
  // Creamos la instancia con firebase notification
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Creamos la funcion para inicializar la notificacion
  Future<void> initNotification() async {
    // Pedir permiso al usuario de la notificaicon
    await _firebaseMessaging.requestPermission();

    // Buscar/OBtener el token
    final tokenFcm = await _firebaseMessaging.getToken();

    // Imprimir el token para corroborarlo
    debugPrint('FCM Token: $tokenFcm');

    // Guardamos el token en el provider
    // Si es diferente de null
    if (tokenFcm != null) {
      debugPrint('Token guardado con exito de la clase firebase notification');
    }

    // Manejar notificaciones cuando la app está en primer plano
    //FirebaseMessaging.onMessage.listen();
  }
}
