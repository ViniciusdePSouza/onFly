import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onfly/src/components/expense_input.dart';
import 'package:onfly/src/constants/controllers.dart';
import 'package:onfly/src/models/expenses.dart';
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
  final TextEditingController _destinationCity = TextEditingController();
  final TextEditingController _ticketPrice = TextEditingController();
  final TextEditingController _checkedBags = TextEditingController();
  final TextEditingController _passengersNumber = TextEditingController();
  final TextEditingController _tripDescription = TextEditingController();
  final TextEditingController _dateDeparture = TextEditingController();
  final TextEditingController _dateReturn = TextEditingController();
  final TextEditingController _airCompany = TextEditingController();
  final TextEditingController _boardingPass = TextEditingController();

  bool _readOnly = true;

  List<ExpenseDTO> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _readOnly ? buildDataText() : buildForm()),
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
    Column(
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
    );
  }

  buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _destinationCity,
          decoration: const InputDecoration(
            labelText: 'Destination City',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _airCompany,
          decoration: const InputDecoration(
            labelText: 'Air Company',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _boardingPass,
          decoration: const InputDecoration(
            labelText: 'Boarding Pass',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _ticketPrice,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Ticket Price (two ways)',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _checkedBags,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Number of Checked Bags',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _passengersNumber,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Number of Passengers',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _tripDescription,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Trip Description',
          ),
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  expenses.add(ExpenseDTO(description: '', expenseValue: ''));
                });
              },
              child: const Text('Adicionar Despesa'),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ExpenseInput(
                  expense: expenses[index],
                  onChanged: (description, expense) {
                    setState(() {
                      expenses[index] = ExpenseDTO(
                        description: description,
                        expenseValue: expense,
                      );
                    });
                  },
                );
              },
            ),
          ],
        ),
        TextField(
          controller: _dateDeparture,
          onTap: () {
            selectDate(_dateDeparture);
          },
          readOnly: true,
          decoration: const InputDecoration(
              labelText: 'Depart Date',
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue))),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: _dateReturn,
          onTap: () {
            selectDate(_dateReturn);
          },
          readOnly: true,
          decoration: const InputDecoration(
              labelText: 'Return Date',
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue))),
        ),
        ElevatedButton(
          onPressed: () {
            List<String> expenseStrings = expenses.map((expense) {
              return 'Description: ${expense.description}, Expense: ${expense.expenseValue}';
            }).toList();
            Map<String, dynamic> newTrip = {
              'destinationCity': _destinationCity.text,
              'arCompany': _airCompany.text,
              'boardingPass': _boardingPass.text,
              'ticketPrice': _ticketPrice.text,
              'checkedBags': _checkedBags.text,
              'passengers': _passengersNumber.text,
              'tripDescription': _tripDescription.text,
              'otherExpenses': expenseStrings,
              'departureDate': _dateDeparture.text,
              'returnDate': _dateReturn.text,
              'boardingHour': '${DateTime.now().hour}:${DateTime.now().minute}',
              'userEmail': userController.user.user!.email
            };
            print('PUT ON DATA BASE');
            print(newTrip);
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }

  Future<void> selectDate(TextEditingController controller) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_picked != null) {
      controller.text = _picked.toString().split(' ')[0];
    }
  }
}
