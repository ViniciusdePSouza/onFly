import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/chart_caption.dart';
import 'package:onfly/src/components/details_row.dart';
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
    double defaultExpenses =
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
          .map((item) => DetailsRow(
              field: '${item.description}:', content: item.expenseValue))
          .toList(),
    );
  }

  buildDataText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsRow(
            field: 'Destination City',
            content: widget.trip.destinationCity,
          ),
          DetailsRow(
            field: 'Boarding Pass',
            content: widget.trip.boardingPass,
          ),
          DetailsRow(
            field: 'Departure Date',
            content:
                '${widget.trip.departureDate.day}/${widget.trip.departureDate.month}/${widget.trip.departureDate.year}',
          ),
          DetailsRow(
            field: 'Return Date',
            content:
                '${widget.trip.returnDate.day}/${widget.trip.returnDate.month}/${widget.trip.returnDate.year}',
          ),
          DetailsRow(
              field: 'Description', content: widget.trip.tripDescription),
          DetailsRow(
              field: 'Number of passengers',
              content: widget.trip.passengers.toString()),
          DetailsRow(
              field: 'Number of bags checked',
              content: widget.trip.checkedBags.toString()),
          DetailsRow(
              field: 'Ticket Price',
              content: widget.trip.ticketPrice.toString()),
          const Text(
            'Expenses:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          DetailsRow(
              field: 'Expenses with tickets',
              content:
                  '${widget.trip.ticketPrice} * ${widget.trip.passengers} = ${widget.trip.ticketPrice.toDouble() * widget.trip.passengers.toInt()}'),
          DetailsRow(
              field: 'Expense with bags',
              content:
                  '${widget.trip.checkedBags} * 200 = ${widget.trip.checkedBags.toInt() * 200}'),
          Visibility(
            visible: widget.trip.otherExpenses != null &&
                widget.trip.otherExpenses!.isNotEmpty,
            child: buildOtherExpenses(),
          ),
          DetailsRow(
              field: 'Total Expenses:',
              content: calculateExpenses().toString()),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue[600]!),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
              onPressed: () {
                Get.toNamed('/update_trip', arguments: {'trip': widget.trip});
              },
              child: const Text(
                'Edit',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              )),
          const SizedBox(
            height: 12,
          ),
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
        ChartCaptionComponent(
          sector: sector,
          totalExpense: totalExpense,
        )
    ],
  );
}
