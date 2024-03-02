import 'package:app_shipper/src/features/price_setting_ride_hailing/price_setting_ride_hailing_view_model.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/shared/app_bar.dart';
import 'package:app_shipper/src/shared/button.dart';
import 'package:app_shipper/src/shared/my_scaffold.dart';
import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';

class PriceSettingRideHailingScreen extends StatelessWidget {
  const PriceSettingRideHailingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PriceSettingRideHailingViewModel>();
    return MyScaffold(
      bgColor: Palette.white,
      padding: EdgeInsets.zero,
      appBar:MyAppBar(
        title: viewModel.isGoiXe == true ?"Cài đặt phí gọi xe" : "Cài đặt phí giao đồ ăn",
        backgroundColor: Palette.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      )
      , body: Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          children: [
            Expanded(
                child: Column(
                    children: viewModel.isGoiXe == true ? viewModel.widgetForm : viewModel.widgetDelivery()
                )
            ),
            BoxConst.s16,
            MyButton(
                title: 'Xác nhận',
                borderRadius: 4,
                action: () async{
                  context.hideKeyboard;
                  if(viewModel.isGoiXe == true){
                    await viewModel.updateFee();
                  }else {
                    await viewModel.updatePhiGiaoHang();
                  }
                })
          ],
        ),
      ),
    ),);
  }
}
