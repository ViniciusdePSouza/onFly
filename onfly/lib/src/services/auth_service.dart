import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/constants/controllers.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  showSnack(String title, String errorMessage) {
    Get.snackbar(title, errorMessage,
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      userController.changeUser(user);
      Get.offAllNamed('/');
    } catch (e) {
      if (e is FirebaseAuthException) {
        showSnack('Login Error', e.message ?? 'An error occurred');
      } else {
        showSnack('Login Error', 'An error occurred try again later');
      }
    }
  }
}
