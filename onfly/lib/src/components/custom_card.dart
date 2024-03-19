import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:onfly/src/models/trip.dart';

class CustomCard extends StatelessWidget {
  final TripDTO trip;

  const CustomCard({
    Key? key,
    required this.trip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.blue[50],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Image.network(
              'https://picsum.photos/170/100',
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.destinationCity.length > 7
                      ? '${trip.destinationCity.substring(0, 7)}...'
                      : trip.destinationCity,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  '${trip.departureDate.day}/${trip.departureDate.month}/${trip.departureDate.year}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[600]!),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)))),
                  onPressed: () {
                    Get.toNamed('/details', arguments: {'trip': trip});
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_right, color: Colors.white,),
                      Text(
                        'Details',
                        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
