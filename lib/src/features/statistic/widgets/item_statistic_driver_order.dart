import 'package:app_shipper/src/models/list_order_model/order.dart';

import '../../../utils/app_enum.dart';
import '../../../utils/extensions/extensions.dart';

import '../../../navigator/app_navigator.dart';
import '../../../navigator/routes.dart';
import 'package:flutter/material.dart';

import '../../../configs/config.dart';

class ItemStatisticDriverOrder extends StatelessWidget {
  const ItemStatisticDriverOrder(
    this.order, {
    Key? key,
  }) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.push(Routes.detailOrder, arguments: order.id);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: Palette.orange),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 0.25.sw,
              height: 0.25.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Palette.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: order.shipper?.loaixe == VehicleType.motobike.code
                    ? Assets.images.motobike.image()
                    : Assets.images.car.image(),
              ),
            ),
            BoxConst.s8,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(text: 'Hóa đơn ', children: [
                            TextSpan(
                              text: order.orderNumber,
                              style: AppFont.t.s(16).w700.red,
                            ),
                          ]),
                          style: AppFont.t.s(16),
                        ),
                      ),
                      if (order.paymentMethod == PaymentMethodEnum.cash.method)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Assets.images.tienMat
                              .image(height: 24, width: 24),
                        ),
                    ],
                  ),
                  BoxConst.s4,
                  Text(
                    order.shipper?.location ?? "",
                    style: AppFont.t,
                  ),
                  BoxConst.s12,
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        order.total.toString().toVnd,
                        style: AppFont.t.green,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
