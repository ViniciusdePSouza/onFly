import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/constants/controllers.dart';
import 'package:onfly/src/controllers/user_controller.dart';
import 'package:onfly/src/screens/NewTravel/models/expenses.dart';

class NewTravelScreen extends StatefulWidget {
  const NewTravelScreen({super.key});

  @override
  State<NewTravelScreen> createState() => _NewTravelScreenState();
}

class _NewTravelScreenState extends State<NewTravelScreen> {
  final TextEditingController _destinationCity = TextEditingController();
  final TextEditingController _ticketPrice = TextEditingController();
  final TextEditingController _checkedBags = TextEditingController();
  final TextEditingController _passengersNumber = TextEditingController();
  final TextEditingController _tripDescription = TextEditingController();
  final TextEditingController _dateDeparture = TextEditingController();
  final TextEditingController _dateReturn = TextEditingController();
  List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Travel'),
        ),
        body: SingleChildScrollView(
          child:
              Padding(padding: const EdgeInsets.all(16.0), child: buildForm()),
        ),
        drawer: buildDrawer());
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

  buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu')),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Get.offNamed('/');
            },
          ),
          ListTile(
            title: const Text('Credit Card Info'),
            onTap: () {
              Get.offNamed('/card');
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
                  expenses.add(Expense(description: '', expenseValue: ''));
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
                      expenses[index] = Expense(
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
              'ticketPrice': _ticketPrice.text,
              'checkedBags': _checkedBags.text,
              'passengers': _passengersNumber.text,
              'tripDescription': _tripDescription.text,
              'otherExpenses': expenseStrings,
              'departureDate': _dateDeparture.text,
              'returnDate': _dateReturn.text,
              'userEmail': userController.user.user!.email
            };
            print(newTrip);
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}

class ExpenseInput extends StatefulWidget {
  final Expense expense;
  final void Function(dynamic, dynamic) onChanged;

  const ExpenseInput({
    Key? key,
    required this.expense,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ExpenseInput> createState() => _ExpenseInputState();
}

class _ExpenseInputState extends State<ExpenseInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              widget.expense.description = value;
            });
          },
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        const SizedBox(height: 8.0),
        TextField(
          onChanged: (value) {
            setState(() {
              widget.expense.expenseValue = value;
            });
          },
          decoration: const InputDecoration(labelText: 'Expense'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
