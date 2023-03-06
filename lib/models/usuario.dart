import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String name;
  final String email;
  final String imageProfile;

  Usuario({
    required this.imageProfile,
    required this.name,
    required this.email,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Usuario(
        name: data?['name'],
        email: data?['email'],
        imageProfile: data?['imageProfile']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (imageProfile != null) "imageProfile": imageProfile,
    };
  }
}
