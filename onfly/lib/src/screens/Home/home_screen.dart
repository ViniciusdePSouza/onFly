import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/custom_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCard(
              city: 'London',
              date: DateTime.now(),
            ),
            CustomCard(
              city: 'Tokyo',
              date: DateTime.now(),
            ),
            CustomCard(
              city: 'Paris',
              date: DateTime.now(),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Menu')),
            ListTile(
              title: const Text('Credit Card Info'),
              onTap: () {
                Get.offNamed('/card');
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
