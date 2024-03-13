import 'package:flutter/material.dart';

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
               Navigator.pushReplacementNamed(context, '/');
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