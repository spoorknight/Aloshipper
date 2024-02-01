import 'package:flutter/material.dart';

import '../../../../configs/config.dart';

class DrawDottedHorizontalLine extends CustomPainter {
  late Paint _paint;
  late double _dotSpacing;

  DrawDottedHorizontalLine({
    double dotSpacing = 6.0,
    Color color = Palette.newLightGrey,
    double strokeWidth = 2,
  }) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    _dotSpacing = dotSpacing;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = 0; i < size.width; i = i + 15) {
      if (i % 3 == 0) {
        canvas.drawLine(Offset(i, 0.0), Offset(i + _dotSpacing, 0.0), _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
