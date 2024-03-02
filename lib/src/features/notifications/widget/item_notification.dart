import 'dart:math' as math;

import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/navigator/routes.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../models/list_notification_model/notification_model.dart';
import '../../../utils/helpers/logger.dart';

class ItemNoti extends StatelessWidget {
  const ItemNoti({Key? key, required this.noti}) : super(key: key);

  final NotificationModel noti;

  void onTapNoti(item) {
    Logger.d('Notification Type', item.type);
    switch (item.type) {
      case 'order':
        if (noti.getOrderId != null) {
          AppNavigator.push(Routes.detailOrder, arguments: noti.getOrderId);
        }
        break;
      default:
    }
  }

  Widget _titleWidget(double animationValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            noti.getIconNoti,
            const SizedBox(
              width: 6,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noti.getTitleNoti,
                  style: AppFont.t.s(14).w400.black,
                ),
                Row(
                  children: [
                    Text(
                      noti.getTime,
                      style: AppFont.t.s(10).w400.nuatral50,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: Palette.nuatral50,
                      ),
                    ),
                    Text(
                      noti.getDate,
                      style: AppFont.t.s(10).w400.nuatral50,
                    ),
                  ],
                )
              ],
            )),
            Transform.rotate(
              angle: math.pi * 2 * animationValue / 2,
              alignment: Alignment.center,
              child: Assets.svgs.back.svg(width: 24, height: 24),
            )
          ],
        ),
        if (noti.getOrderStatusLabel != null)
          Container(
            decoration: BoxDecoration(
                color: noti.getBgColorStatus,
                borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            margin: const EdgeInsets.only(top: 3),
            child: Text(
              noti.getOrderStatusLabel ?? '',
              style: AppFont.t
                  .s(10)
                  .w700
                  .primary
                  .copyWith(color: noti.getColorStatus),
            ),
          )
      ],
    );
  }

  Widget _renderRowContent(ListNotificationModel item) {
    return InkWell(
      onTap: () => onTapNoti(item),
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(width: 1, color: Palette.nuatral20))),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.getTitle,
                      style: AppFont.t.s(13).w700.nuatral90,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Icon(
                        Icons.circle,
                        size: 4.w,
                        color: Palette.nuatral90,
                      ),
                    ),
                    Text(
                      item.getTime,
                      style: AppFont.t.s(13).w400.nuatral90,
                    ),
                  ],
                ),
                Text(
                  item.getMessage,
                  style: AppFont.t.s(10).w400.black,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _renderContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(children: [
        ...noti.getListNoties.map(
          (e) => _renderRowContent(e),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: AppTheme.boxDecoration.copyWith(borderRadius: BorderRadius.circular(10)),
      child: ExpansionWidget(
          initiallyExpanded: false,
          titleBuilder:
              (double animationValue, _, bool isExpaned, toogleFunction) {
            return InkWell(
                onTap: () => toogleFunction(animated: true),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _titleWidget(animationValue),
                ));
          },
          content: _renderContent()),
    );
  }
}
