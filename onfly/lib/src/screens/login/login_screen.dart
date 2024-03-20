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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.network(
                      'https://c5gwmsmjx1.execute-api.us-east-1.amazonaws.com/prod/empresa/logo/84173/logo_onfly.png'),
                ),
                const SizedBox(height: 12),
                TextField(
                  cursorColor: Colors.blue,
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Digite seu email',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  cursorColor: Colors.blue,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Digite sua senha',
                        
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ))),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue[600]!),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
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
                          _passwordController.text, service);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      final auth = FirebaseAuth.instance;
                      auth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.blue),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> loginEmailPassword(
    String email, String password, AuthService service) async {
  await service.login(email, password);
}
