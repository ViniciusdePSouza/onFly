
import 'package:flutter/material.dart';
import 'package:onfly/src/models/expenses.dart';

class ExpenseInput extends StatefulWidget {
  final ExpenseDTO expense;
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