import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/credit_cart_component.dart';
import 'package:onfly/src/constants/controllers.dart';
import 'package:onfly/src/controllers/credit_card_controller.dart';
import 'package:onfly/src/models/transactions_model.dart';

class CardInfoScreen extends StatefulWidget {
  const CardInfoScreen({super.key});

  @override
  State<CardInfoScreen> createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  CreditCardController creditCardController = CreditCardController.instance;

  List<TransactionsDTO> list = [
    TransactionsDTO(description: 'dentist', value: '-2000'),
    TransactionsDTO(description: 'Salary', value: '5000'),
  ];

  @override
  void initState() {
    creditCardController.getCards(userController.user.user?.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(creditCardController.creditCard);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card Information'),
      ),
      body: Center(child: buildCardInfo()),
      drawer: Drawer(
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
              title: const Text('New Travel'),
              onTap: () {
                Get.offNamed('/new_travel');
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
      ),
    );
  }

  Widget buildCardInfo() {
    return Obx(() {
      if (creditCardController.creditCard.isEmpty) {
        return const CircularProgressIndicator();
      } else {
        return Center(
          child: Column(
            children: [
              CreditCardComponent(model: creditCardController.creditCard[0]),
              Text(
                  'Balance: ${calculateBalance(creditCardController.creditCard[0].transactions)}'),
              Expanded(
                child: buildBankStatement(
                    creditCardController.creditCard[0].transactions),
              )
            ],
          ),
        );
      }
    });
  }

  Widget buildBankStatement(List<TransactionsDTO> transactions) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        TransactionsDTO transaction = transactions[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
              '${transaction.description.toString()}: ${transaction.value.toString()}'),
        );
      },
    );
  }

  double calculateBalance(List<TransactionsDTO> transactions) {
    var moneyArray = transactions
        .map((transaction) => double.parse(transaction.value))
        .toList();

    double balance = moneyArray.reduce((value, element) => value + element);

    return balance;
  }
}
