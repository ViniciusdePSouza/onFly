import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onfly/src/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  AuthService service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                    if (_passwordController.text.isEmpty ||
                        _emailController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Erro ao fazer Login'),
                              content: const Text(
                                  'Todos os campos devem ser preenchidos'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Fechar'))
                              ],
                            );
                          });
                    }
                    loginEmailPassword(_emailController.text,
                        _passwordController.text, service, context);
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
    );
  }
}

Future<void> loginEmailPassword(String email, String password,
    AuthService service, BuildContext context) async {
  UserCredential? user = await service.login(email, password);

  if (user != null) {
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/');
  } else {
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro ao fazer Login'),
            content: const Text('Nao foi possível fazer login'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Fechar'))
            ],
          );
        });
  }
}
