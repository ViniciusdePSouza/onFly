import 'package:flutter/material.dart';

class DetailsRow extends StatefulWidget {
final String content;
final String field;

  const DetailsRow({super.key, required this.content, required this.field});

  @override
  State<DetailsRow> createState() => _DetailsRowState();
}

class _DetailsRowState extends State<DetailsRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration:  BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade500,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              '${widget.field}: ${widget.content}',
              style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey[800]),
            ),
          );
  }
}