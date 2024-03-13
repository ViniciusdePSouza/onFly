import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return user;
  }
}
