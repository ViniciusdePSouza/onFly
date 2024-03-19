import 'package:flutter/material.dart';
import 'package:onfly/src/models/transactions_model.dart';

class CardInfoRow extends StatefulWidget {
  final TransactionsDTO transaction;

  const CardInfoRow({super.key, required this.transaction});

  @override
  State<CardInfoRow> createState() => _CardInfoRowState();
}

class _CardInfoRowState extends State<CardInfoRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: double.parse(widget.transaction.value) > 0
                  ? Colors.green
                  : Colors.red,
            )),
        child: Row(
          children: [
            Text(
              '${widget.transaction.description}:',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              widget.transaction.value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: double.parse(widget.transaction.value) > 0
                    ? Colors.green
                    : Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
