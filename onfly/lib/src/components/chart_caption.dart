import 'package:flutter/material.dart';
import 'package:onfly/src/models/sectors.dart';

class ChartCaptionComponent extends StatefulWidget {
  final Sectors sector;
  final double totalExpense;
  const ChartCaptionComponent(
      {super.key, required this.sector, required this.totalExpense});

  @override
  State<ChartCaptionComponent> createState() => _ChartCaptionComponentState();
}

class _ChartCaptionComponentState extends State<ChartCaptionComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
            
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: widget.sector.color,
                borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
              '${widget.sector.description}: ${((widget.sector.value / widget.totalExpense) * 100).toStringAsFixed(2)}%'),
        ],
      ),
    );
  }
}
