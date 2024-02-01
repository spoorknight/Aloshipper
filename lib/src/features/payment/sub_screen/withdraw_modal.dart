import 'package:app_shipper/src/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../payment_view_model.dart';
import 'cash_tab.dart';
import 'transfer_tab.dart';

class WithdrawModal extends StatelessWidget {
  const WithdrawModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PaymentViewModel>();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          BoxConst.s8,
          Text('Rút tiền', style: AppFont.t.s(18).red),
          const Divider(color: Palette.grey),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Palette.grey,
                ),
              ),
            ),
            child: TabBar(
              indicatorColor: Palette.transparent,
              labelStyle: AppFont.t.underline,
              unselectedLabelStyle: AppFont.t,
              labelColor: Palette.red,
              unselectedLabelColor: Palette.black,
              tabs: [
                ChangeNotifierProvider.value(
                  value: viewModel,
                  child: const Tab(child: Text('Chuyển khoản')),
                ),
                ChangeNotifierProvider.value(
                  value: viewModel,
                  child: const Tab(child: Text('Tiền mặt')),
                ),
              ],
            ),
          ),
          const Expanded(child: TabBarView(children: [Transfer(), Cash()]))
        ],
      ),
    );
  }
}
