import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/custom_card.dart';
import 'package:onfly/src/constants/controllers.dart';
import 'package:onfly/src/controllers/credit_card_controller.dart';
import 'package:onfly/src/controllers/user_controller.dart';
import 'package:onfly/src/models/expenses.dart';
import 'package:onfly/src/models/trip.dart';

import '../../controllers/trip_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TripController tripController = TripController.instance;
    CreditCardController creditCardController = CreditCardController.instance;

  @override
  void initState() {
    tripController.listTrips(userController.user.user?.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(tripController.trips);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Obx(
        () => ListView.builder(
          itemCount: tripController.trips.length,
          itemBuilder: (context, index) {
            TripDTO trip = tripController.trips[index];
            return CustomCard(trip: trip);
          },
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
