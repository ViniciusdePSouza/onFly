import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            const Text('Home Screen weorks'),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();

                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Log out')),
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
                 Navigator.pushReplacementNamed(context, '/card');
              },
            ),
            ListTile(
              title: const Text('New Travel'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/new_travel');
              },
            )
          ],
        ),
      ),
    );
  }
}
