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
    //final tokenFcm = await _firebaseMessaging.getToken();

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('Permiso de notificaciones otorgado');
    } else {
      debugPrint('Permiso de notificaciones no otorgado');
    }
  }
}
