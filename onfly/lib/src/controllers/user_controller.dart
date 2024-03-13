import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  late Rx<UserCredential> _loggedUser;

 UserCredential get user => _loggedUser.value;
  
  void changeUser(UserCredential user) {
    _loggedUser = Rx<UserCredential> (user);
  } 
}