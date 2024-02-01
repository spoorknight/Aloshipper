import 'package:app_shipper/src/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/event/voucher_transfer_model.dart';
import '../../../navigator/app_navigator.dart';
import '../../../shared/dialog.dart';
import '../../../utils/app_enum.dart';
import '../../../widgets/voucher_transfer_item.dart';
import '../event_view_model.dart';

class TransferVoucherWidget extends StatelessWidget {
  const TransferVoucherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventViewModel>(builder: (context, viewModel, _) {
      return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.lstVouchersTransfer.length,
        separatorBuilder: (context, index) => BoxConst.s8,
        itemBuilder: (context, index) {
          VoucherTransferModel item = viewModel.lstVouchersTransfer[index];

          return VoucherTransferItem(
            title: item.getTitleVoucher,
            money: item.getValueVoucher,
            pointNeedToChange: item.getPointNeedToTransfer,
            isEnoughPoint:
                (viewModel.customerPointInfoModel?.getUserCurrentPoints ?? 0) >=
                    item.getPointNeed,
            onTap: () {
              showDialog(
                context: context,
                builder: (builder) {
                  return DialogConfirmTransfer(
                    mess: 'Bạn có chắc chắn muốn đổi voucher này?',
                    confirmName: 'Xác nhận',
                    action: () {
                      viewModel.exchangePointsToGift(
                          item.value!, ExchangeType.money.value, item.id!);
                      AppNavigator.pop();
                    },
                  );
                },
              );
            },
          );
        },
      );
    });
  }
}
