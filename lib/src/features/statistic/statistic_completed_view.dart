import 'package:app_shipper/src/features/statistic/statistic_view_model.dart';
import 'package:app_shipper/src/features/statistic/widgets/item_order.dart';
import 'package:app_shipper/src/models/list_order_model/list_order_statistic_model.dart';
import 'package:app_shipper/src/models/list_order_model/order.dart';
import 'package:app_shipper/src/shared/empty.dart';
import 'package:app_shipper/src/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/config.dart';

class StatisticCompletedView extends StatelessWidget {
  StatisticViewModel viewModel;
  StatisticCompletedView({super.key,required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return  SmartRefresher(
      controller: viewModel.refreshCtl,
      onLoading: () => viewModel.loadMoreOrderCompleted(),
      enablePullUp: viewModel.isLastPage ? false : true,
      onRefresh: () => viewModel.onRefreshCompleted(),
      child: viewModel.isLoading
          ? const Loading()
          : viewModel.ordersCompleted.isEmpty
          ? const Empty()
          : ListView.separated(
          controller: viewModel.scrollCrl,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: viewModel.ordersCompleted.length,
          separatorBuilder: (_, i) => BoxConst.s8,
          itemBuilder: (_, i) {
            OrderStatisticModel item = viewModel.ordersCompleted[i];
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
