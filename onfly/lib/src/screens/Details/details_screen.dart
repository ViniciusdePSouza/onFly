import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onfly/src/models/trip.dart';

class DetailsScreen extends StatefulWidget {
  final TripDTO trip;

  const DetailsScreen({
    Key? key,
    required this.trip,
  }) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Destination: ${widget.trip.destinationCity}}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
                'Departure Date: ${widget.trip.departureDate.day}/${widget.trip.departureDate.month}/${widget.trip.departureDate.year}'),
            Text(
                'Return Date: ${widget.trip.departureDate.day}/${widget.trip.departureDate.month}/${widget.trip.departureDate.year}'),
            Text('Description:'),
            Text(widget.trip.tripDescription),
            Text('Number of passengers: ${widget.trip.passengers}'),
            Text('Numeber of bags checked: ${widget.trip.checkedBags}'),
            Text('Numeber of bags checked: ${widget.trip.ticketPrice}'),
            Text('Expenses:'),
            Text(
                'Expenses with tickets: ${widget.trip.ticketPrice} * ${widget.trip.passengers} = ${widget.trip.ticketPrice.toDouble() * widget.trip.passengers.toInt()}'),
            Text(
                'Expense with bags: 200 * ${widget.trip.checkedBags} = ${widget.trip.checkedBags.toInt() * 200}'),
            if (widget.trip.otherExpenses != null &&
                widget.trip.otherExpenses!.isNotEmpty)
              buildOtherExpenses(),

              Text('Total Expenses: ${calculateExpenses().toString()}')
          ],
        ),
      ),
    );
  }

  double calculateExpenses() {
    double defaultExpenses = widget.trip.ticketPrice.toDouble() +
        (widget.trip.passengers.toDouble() * widget.trip.ticketPrice) +
        (widget.trip.checkedBags.toDouble() * 200);
    double otherExpensesCalculated = 0;
    if (widget.trip.otherExpenses != null &&
        widget.trip.otherExpenses!.isNotEmpty) {
      List<double> expensesArray = widget.trip.otherExpenses!
          .map((e) => double.tryParse(e.expenseValue) ?? 0.0)
          .toList();

      otherExpensesCalculated =
          expensesArray.reduce((value, element) => value + element);
    }

    return defaultExpenses + otherExpensesCalculated;
  }

  buildOtherExpenses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.trip.otherExpenses!
          .map((item) => Text('${item.description}: ${item.expenseValue}'))
          .toList(),
    );
  }
}
