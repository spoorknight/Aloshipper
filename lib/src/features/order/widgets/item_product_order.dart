import 'package:app_shipper/src/models/list_order_model/order_firebase_model.dart';
import 'package:app_shipper/src/shared/cache_image_network.dart';
import 'package:app_shipper/src/utils/app_enum.dart';

import '../../../utils/extensions/extensions.dart';

import '../../../navigator/app_navigator.dart';
import '../../../navigator/routes.dart';
import 'package:flutter/material.dart';

import '../../../configs/config.dart';

class ItemProductOrder extends StatelessWidget {
  const ItemProductOrder(
    this.order, {
    Key? key,
  }) : super(key: key);

  final OrderFirebaseModel order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.push(Routes.detailOrder, arguments: order.orderId);
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
              child: CachedNetworkImageCustom(
                url: order.userAvatar ?? "",
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
                    order.shopName ?? "",
                    style: AppFont.t.w700.orange,
                  ),
                  BoxConst.s4,
                  Text(
                    order.shopLocation ?? "",
                    style: AppFont.t.orange,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Trạng thái: ',
                      style: AppFont.t,
                      children: [
                        TextSpan(text: order.statusText, style: AppFont.t.red),
                      ],
                    ),
                  ),
                  BoxConst.s12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Palette.orange),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${order.countItem} sp',
                          style: AppFont.t.orange,
                        ),
                      ),
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
