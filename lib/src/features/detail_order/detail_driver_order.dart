import 'dart:async';

import 'package:app_shipper/src/features/detail_order/widgets/dialog_fee_service.dart';
import 'package:app_shipper/src/models/detail_order_model/detail_order_model.dart';
import 'package:app_shipper/src/models/detail_order_model/item.dart';
import 'package:app_shipper/src/models/shared_models/shipper_model.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/navigator/routes.dart';
import 'package:app_shipper/src/shared/app_bar.dart';
import 'package:app_shipper/src/shared/cache_image_network.dart';
import 'package:app_shipper/src/utils/constants.dart';
import 'package:app_shipper/src/utils/utils.dart';
import 'package:app_shipper/src/widgets/base_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../di/injection/injection.dart';
import '../../models/hive/shipper_call_customer_adapter.dart';
import '../../shared/button.dart';
import '../../shared/loading.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/show_toast.dart';
import '../../shared/text_content/row_content.dart';
import '../../utils/app_enum.dart';
import '../../utils/extensions/extensions.dart';
import 'detail_order_view_model.dart';
import 'item_product.dart';

part 'widgets/item_driver.dart';

part 'widgets/map_widget.dart';

part 'widgets/order_product_detail.dart';

part 'widgets/order_shipper_detail.dart';

part 'widgets/payment_method.dart';

class DetailOrder extends StatelessWidget {
  const DetailOrder({Key? key, this.resetTime}) : super(key: key);
  final int? resetTime;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailOrderViewModel>();
    final order = viewModel.detailOrder?.item;
    return viewModel.isLoading
        ? const Loading()
        : MyScaffold(
            bgColor: Palette.newLightGrey,
            padding: EdgeInsets.zero,
            appBar: MyAppBar(
              backgroundColor: Palette.white,
              leading: InkWell(
                child: const Icon(Icons.arrow_back_ios, color: Palette.black),
                onTap: () => AppNavigator.pop(),
              ),
              titleWidget: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Đơn hàng #${order?.orderNumber}',
                      style: AppFont.t.w700.s(16).black,
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: order?.getColorStatus.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                        order?.statusText ?? '',
                        style: AppFont.t
                            .s(13)
                            .w700
                            .copyWith(color: order?.getColorStatus),
                      ),
                    ),
                  ],
                ),
                BoxConst.size(15),
              ],
            ),
            body: order?.type == Constants.DI_CHUYEN
                ? ChangeNotifierProvider.value(
                    value: viewModel,
                    child: OrderShipperDetail(resetTime: resetTime),
                  )
                : ChangeNotifierProvider.value(
                    value: viewModel,
                    child: OrderProductDetail(resetTime: resetTime),
                  ),
          );
  }
}
