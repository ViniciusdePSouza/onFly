import 'package:flutter/material.dart';

class NewTravelScreen extends StatefulWidget {
  const NewTravelScreen({super.key});

  @override
  State<NewTravelScreen> createState() => _NewTravelScreenState();
}

class _NewTravelScreenState extends State<NewTravelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova viagem'),
      ),
      body: const Center(
        child: Text('New travel rout works!'),
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
              title: const Text('Home'),
              onTap: () {
                 Navigator.pushReplacementNamed(context, '/');
              },
            )
          ],
        ),
      ),
    );
  }
}
