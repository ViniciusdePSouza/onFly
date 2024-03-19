import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onfly/src/models/sectors.dart';

// ignore: must_be_immutable
class PizzaChart extends StatelessWidget {
  late List<Sectors> sectors;

  PizzaChart({super.key, required this.sectors});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: PizzaChartPainter(sectorsList: sectors),
    );
  }
}

class PizzaChartPainter extends CustomPainter {
  final List<Sectors> sectorsList;

  PizzaChartPainter({required this.sectorsList});

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -pi / 2;
    for (final sector in sectorsList) {
      final totalSectorSummed = sectorsList.fold(
          0.0, (previousValue, element) => previousValue + element.value);
      const fullCycleInRadius = 2 * pi;
      final sectorPercent = sector.value / totalSectorSummed;
      final sweepAngle = sectorPercent * fullCycleInRadius;

      final paintPrimitive = Paint()
        ..color = sector.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 30;

      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width / 2, size.height / 2),
              width: size.width,
              height: size.height),
          startAngle,
          sweepAngle,
          false,
          paintPrimitive);

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


