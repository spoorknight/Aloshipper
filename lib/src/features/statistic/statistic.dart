import 'package:app_shipper/src/features/statistic/widgets/item_order.dart';
import 'package:app_shipper/src/models/list_order_model/order.dart';
import 'package:app_shipper/src/shared/text_form_field.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../di/injection/injection.dart';
import '../../shared/app_bar.dart';
import '../../shared/empty.dart';
import '../../shared/loading.dart';
import '../../shared/my_scaffold.dart';
import 'package:flutter/cupertino.dart';

import '../../configs/config.dart';
import 'statistic_view_model.dart';
import './widgets/item_statistic_driver_order.dart';
import './widgets/item_statistic_product_order.dart';

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  @override
  void initState() {
    super.initState();
    appData.updateToaDo();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StatisticViewModel>();
    return MyScaffold(
      appBar: const MyAppBar(
        title: 'Thống kê',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    title: 'Từ ngày',
                    hintText: 'dd/mm/yyyy',
                    controller: viewModel.fromDateEC,
                    readOnly: true,
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        currentTime: viewModel.fromDate ?? DateTime.now(),
                        locale: LocaleType.vi,
                        onConfirm: viewModel.selectFromDate,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: viewModel.toDate,
                      );
                    },
                  ),
                ),
                BoxConst.s8,
                Expanded(
                  child: CustomTextFormField(
                    title: 'Đến ngày',
                    hintText: 'dd/mm/yyyy',
                    controller: viewModel.toDateEC,
                    readOnly: true,
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        currentTime: viewModel.toDate ?? DateTime.now(),
                        locale: LocaleType.vi,
                        onConfirm: viewModel.selectToDate,
                        minTime: viewModel.fromDate ?? DateTime(1900, 1, 1),
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: SmartRefresher(
                controller: viewModel.refreshCtl,
                onLoading: () => viewModel.loadMore(),
                enablePullUp: viewModel.isLastPage ? false : true,
                onRefresh: () => viewModel.onRefresh(),
                child: viewModel.isLoading
                    ? const Loading()
                    : viewModel.orders.isEmpty
                        ? const Empty()
                        : ListView.separated(
                            controller: viewModel.scrollCrl,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            itemCount: viewModel.orders.length,
                            separatorBuilder: (_, i) => BoxConst.s8,
                            itemBuilder: (_, i) {
                              Order item = viewModel.orders[i];
                              return ItemOrder(
                                date: item.getDateCreate,
                                time: item.getTime,
                                orderNumber: item.orderNumber,
                                orderId: item.id,
                                storeName: item.getStoreName,
                                type: item.type,
                                status: item.statusText,
                                countProduct: item.countItem,
                                totalAmount: item.total,
                                paymentType: item.getStrPaymentMethod,
                                colorStatus: item.getColorStatus,
                                iconPayment: item.getIconPaymentType,
                              );
                            }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
