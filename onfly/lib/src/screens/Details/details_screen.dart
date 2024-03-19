import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/chart_caption.dart';
import 'package:onfly/src/components/pizza_chart.dart';
import 'package:onfly/src/models/expenses.dart';
import 'package:onfly/src/models/sectors.dart';

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
        title: const Text('Details'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: buildDataText(),
          )),
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

  buildDataText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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
          const Text('Description:'),
          Text(widget.trip.tripDescription),
          Text('Number of passengers: ${widget.trip.passengers}'),
          Text('Number of bags checked: ${widget.trip.checkedBags}'),
          Text('Ticket Price: ${widget.trip.ticketPrice}'),
          const Text('Expenses:'),
          Text(
              'Expenses with tickets: ${widget.trip.ticketPrice} * ${widget.trip.passengers} = ${widget.trip.ticketPrice.toDouble() * widget.trip.passengers.toInt()}'),
          Text(
              'Expense with bags: 200 * ${widget.trip.checkedBags} = ${widget.trip.checkedBags.toInt() * 200}'),
          if (widget.trip.otherExpenses != null &&
              widget.trip.otherExpenses!.isNotEmpty)
            buildOtherExpenses(),
          Text('Total Expenses: ${calculateExpenses().toString()}'),
          ElevatedButton(
              onPressed: () {
                Get.toNamed('/update_trip', arguments: {'trip': widget.trip});
              },
              child: const Text('Edit')),
          Visibility(
              visible: widget.trip.otherExpenses != null,
              child: _buildPizzaChart(
                  widget.trip.otherExpenses!,
                  widget.trip.ticketPrice,
                  widget.trip.passengers,
                  widget.trip.checkedBags))
        ],
      ),
    );
  }
}

_buildPizzaChart(List<ExpenseDTO> expensesList, double ticketPrice,
    int passengers, int checkedBags) {
  late List<Sectors> sectors;
  late double totalExpense;
  sectors = expensesList.map((expense) {
    final random = Random();
    final color = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );

    final value = double.parse(expense.expenseValue);

    return Sectors(
        color: color, value: value, description: expense.description);
  }).toList();

  sectors.add(Sectors(
      description: 'Tickets',
      color: const Color(0xFF0000FF),
      value: ticketPrice * passengers));
  sectors.add(Sectors(
      color: const Color(0xFFFF0000),
      value: checkedBags * 200,
      description: 'Bags'));

  totalExpense = sectors.fold(
      0.0, (previousValue, element) => previousValue + element.value);

  return Column(
    children: [
      PizzaChart(sectors: sectors),
      const SizedBox(
        height: 30,
      ),
      const Text(
        'Legenda',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(
        height: 30,
      ),
      for (var sector in sectors)
        ChartCaptionComponent(sector: sector, totalExpense: totalExpense,)
    ],
  );
}
