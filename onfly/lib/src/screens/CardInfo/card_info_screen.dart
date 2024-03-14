import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/constants/controllers.dart';

class CardInfoScreen extends StatefulWidget {
  const CardInfoScreen({super.key});

  @override
  State<CardInfoScreen> createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card Information'),
      ),
      body: const Center(
        child: Text('Card info route works!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Menu')),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Get.offNamed('/');
              },
            ),
            ListTile(
              title: const Text('New Travel'),
              onTap: () {
                Get.offNamed('/new_travel');
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () {
                FirebaseAuth.instance.signOut();

                Get.offAllNamed('/login');
              },
            )
          ],
        ),
      ),
    );
  }
}
