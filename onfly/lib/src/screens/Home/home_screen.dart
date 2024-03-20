import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/custom_card.dart';
import 'package:onfly/src/constants/controllers.dart';
import 'package:onfly/src/controllers/credit_card_controller.dart';
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
  TextEditingController _searchController = TextEditingController();
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
      body: _buildListHandler(),
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

  _buildListHandler() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _searchController,
                cursorColor: Colors.blue, 
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .blue), 
                  ),
                ),
              )),
              IconButton(
                  onPressed: () {
                    _searchByCityName(_searchController.text);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  ))
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: tripController.trips.length,
              itemBuilder: (context, index) {
                TripDTO trip = tripController.trips[index];
                return CustomCard(trip: trip);
              },
            ),
          ),
        ),
      ],
    );
  }

  _searchByCityName(String city) {
    if (city.isEmpty) {
      tripController.listTrips(userController.user.user?.email!);
      return;
    }

    tripController.filterTripsByCity(city);
  }
}
