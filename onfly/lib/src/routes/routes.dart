import 'package:flutter/material.dart';
import 'package:onfly/src/screens/CardInfo/card_info_screen.dart';
import 'package:onfly/src/screens/Details/details_screen.dart';
import 'package:onfly/src/screens/Home/home_screen.dart';
import 'package:onfly/src/screens/NewTravel/new_travel_screen.dart';
import 'package:onfly/src/screens/login/login_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomeScreen(),
    '/new_travel': (context) => const NewTravelScreen(),
    '/login':(context) => const LoginScreen(),
    '/card': (context) => const CardInfoScreen(),
    '/details': (context) {
      final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final String city = args?['city'];
      final DateTime date = args?['date'];
      
      return DetailsScreen(city: city, date: date);
    },

  };
}