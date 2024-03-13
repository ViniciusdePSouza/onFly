import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/constants/controllers.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    userController.changeUser(user);
    Get.offAllNamed('/');
  }
}
