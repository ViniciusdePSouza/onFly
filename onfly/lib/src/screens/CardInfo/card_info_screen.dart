import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly/src/components/card_info_row.dart';
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

  @override
  void initState() {
    super.initState();

    creditCardController.getCards(userController.user.user?.email!);
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      'Balance:',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.amber[500]),
                    ),
                    const SizedBox(width: 12,),
                    Text(
                      '${calculateBalance(creditCardController.creditCard[0].transactions)}',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: calculateBalance(creditCardController
                                      .creditCard[0].transactions) >
                                  0
                              ? Colors.green
                              : Colors.red),
                    )
                  ],
                ),
              ),
              Expanded(
                child: buildBankStatement(
                    creditCardController.creditCard[0].transactions),
              ),

              // ElevatedButton(
              //     onPressed: () {
              //       firebaseFirestore
              //           .enableNetwork()
              //           .then((value) => print('network enabled'));
              //     },
              //     child: Text('voltar net'))
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
        return CardInfoRow(
          transaction: transaction,
        );
      },
    );
  }

  double calculateBalance(List<TransactionsDTO> transactions) {
    final List<double> moneyArray = transactions
        .map((transaction) => double.parse(transaction.value))
        .toList();

    double balance = moneyArray.reduce((value, element) => value + element);

    return balance;
  }
}
