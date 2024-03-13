import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.airplanemode_active,
                  color: Colors.black,
                  size: 32,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Digite seu email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Digite sua senha',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ))),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_passwordController.text.isEmpty &&
                          _emailController.text.isEmpty) return print('Vazio');
                      login(_emailController.text, _passwordController.text);
                    },
                    child: const Text('Login')),
                TextButton(
                    onPressed: () {
                      final auth = FirebaseAuth.instance;
                      auth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
                    },
                    child: Text('Sign In'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> login(String email, String password) async {
  print('chamando');
  final auth = FirebaseAuth.instance;
  UserCredential user =
      await auth.signInWithEmailAndPassword(email: email, password: password);

  print(user);
}
