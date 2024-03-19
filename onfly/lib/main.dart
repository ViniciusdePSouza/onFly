import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/constants/firebase.dart';
import 'package:onfly/src/controllers/credit_card_controller.dart';
import 'package:onfly/src/controllers/trip_controller.dart';
import 'package:onfly/src/controllers/user_controller.dart';
import 'package:onfly/src/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(UserController());
  Get.put(TripController());
  Get.put(CreditCardController());
  firebaseFirestore.settings = const Settings(persistenceEnabled: true);
  // firebaseFirestore.disableNetwork().then((value) => print('disable network'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: Routes.routes,
    );
  }
}
