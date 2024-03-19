import 'package:flutter/material.dart';
import 'package:onfly/src/constants/controllers.dart';
import 'package:onfly/src/models/credit_card_model.dart';

class CreditCardComponent extends StatefulWidget {
  final CreditCardDTO model;

  const CreditCardComponent({super.key, required this.model});

  @override
  State<CreditCardComponent> createState() => _CreditCardComponentState();
}

class _CreditCardComponentState extends State<CreditCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
      height: 75,
      width: 150,
        decoration: BoxDecoration(
            color: Colors.blue[200], borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${userController.user.user!.email}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
              Text('Flag: ${widget.model.flag}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }
}
