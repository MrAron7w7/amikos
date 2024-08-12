/*
  -------------------------------------
  Perfil de usuario

  Que requiere:

  - uid
  - userName
  - email
  - bio
  - foto de perfil 
  -------------------------------------
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String userName;
  final String bio;
  final String? tokenFcm;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.userName,
    required this.bio,
    this.tokenFcm,
  });

  UserProfile copyWith({
    String? uid,
    String? name,
    String? email,
    String? userName,
    String? bio,
    String? tokenFcm,
  }) =>
      UserProfile(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        bio: bio ?? this.bio,
        tokenFcm: tokenFcm ?? this.tokenFcm,
      );

  /* 
    firebase -> app  

    convertir el documento de firestore a perfil de usuario  en la cual se usa en la app
  
  */

  factory UserProfile.fromDocument(DocumentSnapshot doc) => UserProfile(
        uid: doc['uid'] ?? '',
        name: doc['name'] ?? '',
        email: doc['email'] ?? '',
        userName: doc['userName'] ?? '',
        bio: doc['bio'] ?? '',
        tokenFcm: doc['tokenFcm'] ?? '',
      );

  /* 
    app -> firebase  

    convetir el perfil de usuario a un map se usa en firestore
  
  */

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "email": email,
        "userName": userName,
        "bio": bio,
        "tokenFcm": tokenFcm,
      };
}
