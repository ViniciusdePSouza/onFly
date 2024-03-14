import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String city;
  final DateTime date;

  const DetailsScreen({Key? key, required this.city, required this.date})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('City: ${widget.city}}'),
            Text(
                'Date: ${widget.date.day}/${widget.date.month}/${widget.date.year}'),
          ],
        ),
      ),
    );
  }
}
