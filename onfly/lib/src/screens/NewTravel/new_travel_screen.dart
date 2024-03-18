import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/expense_input.dart';
import 'package:onfly/src/constants/controllers.dart';
import 'package:onfly/src/controllers/trip_controller.dart';
import 'package:onfly/src/controllers/user_controller.dart';
import 'package:onfly/src/models/expenses.dart';
import 'package:onfly/src/models/trip.dart';

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
  final TextEditingController _airCompany = TextEditingController();
  final TextEditingController _boardingPass = TextEditingController();

  TripController tripController = TripController.instance;

  List<ExpenseDTO> expenses = [];

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
            TripDTO newTrip = TripDTO(
              destinationCity: _destinationCity.text,
              airCompany: _airCompany.text,
              boardingPass: _boardingPass.text,
              ticketPrice: double.parse(_ticketPrice.text),
              checkedBags: int.parse(_checkedBags.text),
              passengers: int.parse(_passengersNumber.text),
              tripDescription: _tripDescription.text,
              departureDate: DateTime.parse(_dateDeparture.text),
              returnDate: DateTime.parse(_dateReturn.text),
              otherExpenses: expenses,
              userEmail: userController.user.user!.email!,
              boardingHour: DateTime.now(),
            );
            
            tripController.addTrip(newTrip).then((_) => Get.offAllNamed('/'));
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
