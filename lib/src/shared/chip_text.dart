import 'package:flutter/material.dart';

import '../configs/config.dart';

class ChipText extends StatelessWidget {
  const ChipText({
    super.key,
    required this.bgColor,
    required this.text,
    required this.textColor,
  });
  final Color bgColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Palette.grey.withOpacity(0.5),
            offset: const Offset(-2, 2),
            blurRadius: 1,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        text,
        style: AppFont.t.copyWith(color: textColor),
      ),
    );
  }
}
