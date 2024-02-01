import '../../../utils/extensions/extensions.dart';
// ignore: library_prefixes
import 'package:badges/badges.dart' as badgeCount;
import 'package:flutter/material.dart';

import '../../../configs/config.dart';

class ItemExtend extends StatelessWidget {
  final bool isSelected;
  const ItemExtend({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        badgeCount.Badge(
          showBadge: isSelected,
          badgeStyle: const badgeCount.BadgeStyle(
            badgeColor: Palette.green,
          ),
          position: badgeCount.BadgePosition.topEnd(top: -12, end: -12),
          badgeContent: const Icon(
            Icons.check,
            color: Palette.white,
            size: 12,
          ),
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Palette.grey),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer, size: 30),
                    Text('01 tháng', style: AppFont.t),
                  ],
                ),
              ),
            ),
          ),
        ),
        Text('0'.toVnd, textAlign: TextAlign.right, style: AppFont.t.red),
      ],
    );
  }
}
