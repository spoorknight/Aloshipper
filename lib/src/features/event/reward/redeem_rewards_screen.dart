import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../navigator/app_navigator.dart';
import '../../../shared/app_bar.dart';
import '../../../shared/my_scaffold.dart';
import '../widgets/customer_point_widget.dart';
import '../widgets/transfer_voucher_widget.dart';

class RedeemRewardsScreen extends StatelessWidget {
  const RedeemRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      appBar: MyAppBar(
        title: 'Đổi phần thưởng',
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxConst.s8,
            const CustomerPointWidget(),
            BoxConst.s16,
            const TransferVoucherWidget(),
            // const TransferMoneyWidget(),
          ],
        ),
      ),
    );
  }
}
