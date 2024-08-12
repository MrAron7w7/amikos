import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String uid;
  final String name;
  final String userName;
  final String message;
  final Timestamp timestamp;
  final int likeCount;
  final List<String> likeBy;

  Post({
    required this.id,
    required this.uid,
    required this.name,
    required this.userName,
    required this.message,
    required this.timestamp,
    required this.likeCount,
    required this.likeBy,
  });

  Post copyWith({
    String? id,
    String? uid,
    String? name,
    String? userName,
    String? message,
    Timestamp? timestamp,
    int? likeCount,
    List<String>? likeBy,
  }) =>
      Post(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        userName: userName ?? this.userName,
        message: message ?? this.message,
        timestamp: timestamp ?? this.timestamp,
        likeCount: likeCount ?? this.likeCount,
        likeBy: likeBy ?? this.likeBy,
      );

/* 
    firebase -> app  

    convertir el documento de firestore a perfil de usuario  en la cual se usa en la app  
*/
  factory Post.fromDocument(DocumentSnapshot doc) => Post(
        id: doc.id,
        uid: doc['uid'] ?? '',
        name: doc['name'] ?? '',
        userName: doc['userName'] ?? '',
        message: doc['message'] ?? '',
        timestamp: doc['timestamp'],
        likeCount: doc['likeCount'] ?? 0,
        likeBy: List<String>.from(doc['likeBy'] ?? []),
      );

  /* 
    app -> firebase  

    convetir el perfil de usuario a un map se usa en firestore
  
  */

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'userName': userName,
        'message': message,
        'timestamp': timestamp,
        'likeCount': likeCount,
        'likeBy': likeBy,
      };
}
