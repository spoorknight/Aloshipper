import 'package:flutter/material.dart';

import '../../../configs/config.dart';

class ChevronRightButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const ChevronRightButton({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppFont.t),
            const Icon(Icons.chevron_right, color: Palette.grey),
          ],
        ),
      ),
    );
  }
}
