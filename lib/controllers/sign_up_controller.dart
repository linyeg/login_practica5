import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_practica/models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../perfil.dart';

class SignUpController extends GetxController {
  String email = '';
  String password = '';
  String name = '';
  XFile? photo;
  String profileImage = '';

  handleEmail(String newEmail) {
    email = newEmail;
    update();
  }

  handlePassword(String newPassword) {
    password = newPassword;
    update();
  }

  handleName(String newName) {
    name = newName;
    update();
  }

  handleSignUp() async {
    if (email == '' || password == '' || name == '') {
      return;
    }
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await uploadImage(credential.user!.uid);
        final user = saveUserInDB(credential.user!.uid);
        Get.offAll(() => PerfilScreen(
              usuario: user,
            ));
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code,
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Usuario saveUserInDB(
    String id,
  ) {
    final user = Usuario(name: name, email: email, imageProfile: profileImage);
    final db = FirebaseFirestore.instance;
    db
        .collection("Usuarios")
        .doc(id)
        .set(user.toFirestore())
        .onError((e, _) => print("Error writing document: $e"));

    return user;
  }

  uploadLocalImage() async {
    final ImagePicker picker = ImagePicker(); // Capture a photo
    photo = await picker.pickImage(source: ImageSource.camera);
    update();
  }

  Future<String> uploadImage(
    String id,
  ) async {
    if (photo != null) {
      final lista = photo!.name.split('.');
      String ext = lista.last;
      final storageRef = FirebaseStorage.instance.ref();
      final mountainImagesRef = storageRef.child("imagesProfile/$id.$ext");
      try {
        await mountainImagesRef.putFile(File(photo!.path));
        profileImage = await mountainImagesRef.getDownloadURL();
        return profileImage;
      } catch (e) {
        // ...
      }
    }
    throw Exception('No tienes una imagen');
  }
}
