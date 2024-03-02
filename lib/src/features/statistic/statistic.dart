import 'package:app_shipper/src/features/statistic/statistic_cancel_view.dart';
import 'package:app_shipper/src/features/statistic/statistic_completed_view.dart';
import 'package:app_shipper/src/features/statistic/widgets/item_order.dart';
import 'package:app_shipper/src/models/list_order_model/order.dart';
import 'package:app_shipper/src/shared/text_form_field.dart';
import 'package:flutter/material.dart';
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

class _StatisticState extends State<Statistic> with TickerProviderStateMixin {

  late TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    appData.updateToaDo();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StatisticViewModel>();
    return MyScaffold(
      appBar: const MyAppBar(
        title: 'Quản lý đơn hàng',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: CustomTextFormField(
            //         title: 'Từ ngày',
            //         hintText: 'dd/mm/yyyy',
            //         controller: viewModel.fromDateEC,
            //         readOnly: true,
            //         onTap: () {
            //           DatePicker.showDatePicker(
            //             context,
            //             currentTime: viewModel.fromDate ?? DateTime.now(),
            //             locale: LocaleType.vi,
            //             onConfirm: viewModel.selectFromDate,
            //             minTime: DateTime(1900, 1, 1),
            //             maxTime: viewModel.toDate,
            //           );
            //         },
            //       ),
            //     ),
            //     BoxConst.s8,
            //     Expanded(
            //       child: CustomTextFormField(
            //         title: 'Đến ngày',
            //         hintText: 'dd/mm/yyyy',
            //         controller: viewModel.toDateEC,
            //         readOnly: true,
            //         onTap: () {
            //           DatePicker.showDatePicker(
            //             context,
            //             currentTime: viewModel.toDate ?? DateTime.now(),
            //             locale: LocaleType.vi,
            //             onConfirm: viewModel.selectToDate,
            //             minTime: viewModel.fromDate ?? DateTime(1900, 1, 1),
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              color: Palette.white,
              height: 50,
              child: TabBar(
                labelColor: Palette.black,
                indicatorColor: Palette.black,
                unselectedLabelColor: Palette.grey,
                controller: tabController,
                labelStyle: AppFont.t.s(16).w500,
                tabs:  const [
                  Text('Đơn hoàn thành'),
                  Text('Đơn huỷ'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  StatisticCompletedView(viewModel: viewModel),
                  StatisticCancelView(viewModel: viewModel)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
