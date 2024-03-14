import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/custom_card.dart';
import 'package:onfly/src/models/expenses.dart';
import 'package:onfly/src/models/trip.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCard(
                trip: TripDTO(
                    destinationCity: 'Panamá',
                    ticketPrice: 2500.00,
                    checkedBags: 2,
                    passengers: 2,
                    tripDescription: 'Business Trip ',
                    departureDate: DateTime.now(),
                    returnDate: DateTime.now(),
                    userEmail: 'userEmail@email.com'),
              ),
              CustomCard(
                trip: TripDTO(
                    destinationCity: 'Bogotá',
                    ticketPrice: 2500.00,
                    checkedBags: 2,
                    passengers: 2,
                    tripDescription: 'Business Trip ',
                    departureDate: DateTime.now(),
                    returnDate: DateTime.now(),
                    otherExpenses: [
                      ExpenseDTO(description: 'Medicine', expenseValue: '678987'),
                      ExpenseDTO(description: 'Cloth', expenseValue: '600'),
                    ],
                    userEmail: 'userEmail@email.com'),
              ),
              CustomCard(
                trip: TripDTO(
                    destinationCity: 'London',
                    ticketPrice: 2500.00,
                    checkedBags: 2,
                    passengers: 2,
                    tripDescription: 'Business Trip ',
                    departureDate: DateTime.now(),
                    returnDate: DateTime.now(),
                    userEmail: 'userEmail@email.com'),
              ),
              CustomCard(
                trip: TripDTO(
                    destinationCity: 'Tokyo',
                    ticketPrice: 2500.00,
                    checkedBags: 2,
                    passengers: 2,
                    tripDescription: 'Business Trip ',
                    departureDate: DateTime.now(),
                    returnDate: DateTime.now(),
                    userEmail: 'userEmail@email.com'),
              ),
            ],
          ),
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
