import 'package:flutter/material.dart';

import '../../../../configs/config.dart';

class DrawDottedVerticalLine extends CustomPainter {
  late Paint _paint;
  late double _dotSpacing;

  DrawDottedVerticalLine({
    double dotSpacing = 15.0,
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
    for (double i = 0; i < size.height; i = i + 15) {
      if (i % 3 == 0) {
        canvas.drawLine(Offset(0.0, i), Offset(0.0, i + _dotSpacing), _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
