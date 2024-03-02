import 'package:app_shipper/src/features/statistic/statistic_view_model.dart';
import 'package:app_shipper/src/features/statistic/widgets/item_order.dart';
import 'package:app_shipper/src/models/list_order_model/list_order_statistic_model.dart';
import 'package:app_shipper/src/models/list_order_model/order.dart';
import 'package:app_shipper/src/shared/empty.dart';
import 'package:app_shipper/src/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/config.dart';

class StatisticCancelView extends StatelessWidget {
  StatisticViewModel viewModel;
  StatisticCancelView({super.key,required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return  SmartRefresher(
      controller: viewModel.refreshCtlCancel,
      onLoading: () => viewModel.loadMoreOrderCancel(),
      enablePullUp: viewModel.isLastPageCancel ? false : true,
      onRefresh: () => viewModel.onRefreshCancel(),
      child: viewModel.ordersCancel.isEmpty
          ? const Empty()
          : ListView.separated(
          controller: viewModel.scrollCrlCancel,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: viewModel.ordersCancel.length,
          separatorBuilder: (_, i) => BoxConst.s8,
          itemBuilder: (_, i) {
            OrderStatisticModel item = viewModel.ordersCancel[i];
            return ItemOrder(
              date: item.getDateCreate,
              time: item.getTime,
              orderNumber: item.orderNumber,
              orderId: item.id,
              storeName: item.shopName,
              type: item.type,
              status: item.orderStatusText,
              countProduct: item.numberOfProducts,
              totalAmount: double.tryParse(item.priceTotal ?? "0"),
              paymentType: item.getStrPaymentMethod,
              colorStatus: item.getColorStatus,
              iconPayment: item.getIconPaymentType,
            );
          }),
    );
  }
}
