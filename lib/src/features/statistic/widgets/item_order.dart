import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/navigator/routes.dart';
import 'package:app_shipper/src/utils/constants.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:app_shipper/src/utils/utils.dart';
import 'package:flutter/material.dart';

class ItemOrder extends StatelessWidget {
  final String? date;
  final String? time;
  final String? orderId;
  final String? orderNumber;
  final String? storeName;
  final String? type;
  final String? paymentType;
  final String? status;
  final int? countProduct;
  final double? totalAmount;
  final Color? colorStatus;
  final Widget? iconPayment;
  final int? resetTime;
  final String? updateAt;

  const ItemOrder({
    Key? key,
    this.date,
    this.time,
    this.orderId,
    this.orderNumber,
    this.storeName,
    this.type,
    this.status,
    this.countProduct,
    this.totalAmount,
    this.paymentType,
    this.colorStatus,
    this.iconPayment,
    this.resetTime,
    this.updateAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(context, Routes.detailOrder, arguments: {
          'orderId': orderId,
          "resetTime": Utils().calculatorTimeResetTime(
              resetTime: resetTime ?? 60, updateAt: updateAt),
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: AppTheme.boxDecoration.copyWith(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      date ?? '',
                      style: AppFont.t.s(10).w400.nuatral50,
                    ),
                    if ((time ?? '').isNotEmpty) ...[
                      BoxConst.s4,
                      const CircleAvatar(
                        backgroundColor: Palette.nuatral50,
                        radius: 3,
                      ),
                      BoxConst.s4,
                      Text(
                        time ?? '',
                        style: AppFont.t.s(10).w400.nuatral50,
                      ),
                    ]
                  ],
                ),
                Text(
                  '#$orderNumber',
                  style: AppFont.t.s(10).w400.nuatral50,
                ),
              ],
            ),
            if ((storeName ?? '').isNotEmpty) ...[
              BoxConst.s4,
              Text(
                storeName ?? '',
                style: AppFont.t.s(16).w700.nuatral,
              ),
            ],
            if (type == Constants.DI_CHUYEN) ...[
              BoxConst.s4,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đơn gọi xe',
                    style: AppFont.t.s(16).w700.nuatral,
                  ),
                  Text(
                    '${totalAmount ?? 0}'.toVnd,
                    style: AppFont.t.s(16).w700.nuatral,
                  ),
                ],
              ),
            ],
            if (type != Constants.DI_CHUYEN) ...[
              BoxConst.s4,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'SP: ',
                      style: AppFont.t.s(16).w400.nuatral,
                      children: [
                        TextSpan(
                          text: (countProduct ?? 0).toString(),
                          style: AppFont.t.s(16).w700.nuatral,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$totalAmount'.toVnd,
                    style: AppFont.t.s(16).w700.nuatral,
                  ),
                ],
              ),
            ],
            BoxConst.s4,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (paymentType != null)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (iconPayment != null) ...[
                          iconPayment!,
                        ],
                        BoxConst.s4,
                        Text(
                          paymentType ?? '',
                          style: AppFont.t.s(13).w400.nuatral90,
                        )
                      ],
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: colorStatus?.withOpacity(0.1)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 21),
                  child: Text(
                    '$status',
                    style: AppFont.t
                        .s(10)
                        .w700
                        .nuatral
                        .copyWith(color: colorStatus),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
