import 'package:app_shipper/src/models/list_service_new_model.dart';

import '../../../utils/extensions/extensions.dart';
import 'package:badges/badges.dart' as badge_lib;
import 'package:flutter/material.dart';

import '../../../configs/config.dart';

class ItemExtend extends StatelessWidget {
  final bool isSelected;
  final Packages service;
  const ItemExtend({
    Key? key,
    this.isSelected = false,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        badge_lib.Badge(
          showBadge: isSelected,
          badgeStyle: const badge_lib.BadgeStyle(
            badgeColor: Palette.green,
          ),
          position: badge_lib.BadgePosition.topEnd(top: -10, end: -10),
          badgeContent: const Icon(
            Icons.check,
            color: Palette.white,
            size: 12,
          ),
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Palette.grey),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, size: 30),
                  Text('${service.numberOfDays} ngày', style: AppFont.t),
                ],
              ),
            ),
          ),
        ),
        Text(service.title ?? '',
            textAlign: TextAlign.center, style: AppFont.t),
        Text('${service.price ?? 0}'.toVnd,
            textAlign: TextAlign.center, style: AppFont.t.red),
      ],
    );
  }
}
