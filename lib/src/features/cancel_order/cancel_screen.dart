import 'package:app_shipper/src/configs/app_constants.dart';
import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/features/detail_order/detail_order_view_model.dart';
import 'package:app_shipper/src/models/cancel_order_model.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/navigator/routes.dart';
import 'package:app_shipper/src/shared/app_bar.dart';
import 'package:app_shipper/src/shared/button.dart';
import 'package:app_shipper/src/shared/my_scaffold.dart';
import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../di/injection/injection.dart';
import '../../shared/text_form_field.dart';
import '../../utils/constants.dart';
import 'cancel_order_view_model.dart';

class CancelOrderScreen extends StatelessWidget {
  const CancelOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      padding: EdgeInsets.zero,
      appBar: MyAppBar(
        backgroundColor: Palette.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
        titleWidget: Consumer<DetailOrderViewModel>(
            builder: (context, detailOrderViewModel, _) {
          final order = detailOrderViewModel.detailOrder?.item;
          return Row(
            children: [
              Expanded(
                child: Text(
                  'Hủy hàng #${order?.orderNumber}',
                  style: AppFont.t.w700.s(16).black,
                ),
              ),
            ],
          );
        }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxConst.s8,
                Padding(
                  padding: AppTheme.mainPadding,
                  child: Text(
                    'Lý do hủy đơn hàng?',
                    style: AppFont.t.s(16).w700.nuatral90,
                  ),
                ),
                BoxConst.s8,
                renderReasonCancel(),
              ],
            ),
          ),
          renderBottomButton(),
          BoxConst.size(paddingBottomButton),
        ],
      ),
    );
  }

  Widget renderBottomButton() {
    return Padding(
      padding: AppTheme.mainPadding,
      child: Consumer2<DetailOrderViewModel, CancelOrderViewModel>(
          builder: (context, detailOrderViewModel, cancelOrderViewModel, _) {
        bool enableButton = detailOrderViewModel.detailOrder?.item?.type ==
                Constants.TYPE_MUA_HANG
            ? cancelOrderViewModel.reasonCancelSelected != null
            : true;
        return MyButton(
          color: enableButton ? Palette.primary : Palette.buttonGrey,
          title: 'Gửi yêu cầu hủy đơn',
          titleStyle: AppFont.t.s(14).w700.white,
          borderRadius: 8,
          action: enableButton
              ? () async {
                  context.hideKeyboard;
                  if (cancelOrderViewModel.cancelReasonCtl.text.isEmpty &&
                      (cancelOrderViewModel.reasonCancelSelected ==
                              cancelOrderViewModel.otherReasonCancel.id ||
                          detailOrderViewModel.detailOrder?.item?.type ==
                              Constants.DI_CHUYEN)) {
                    EasyLoading.showError('Không thể để trống lý do hủy đơn');
                  } else {
                    final order = detailOrderViewModel.detailOrder?.item;
                    final res =
                        await cancelOrderViewModel.sendReasonCancel(order?.id);
                    if (res) {
                      // Navigator.of(context).pop(true);
                      AppNavigator.popUntil(Routes.mainScreen);
                    }
                  }
                }
              : null,
        );
      }),
    );
  }

  Widget renderReasonCancel() {
    return Consumer<CancelOrderViewModel>(
        builder: (context, cancelOrderViewModel, _) {
      final order = detailOrderViewModel.detailOrder?.item;
      if (order?.type == Constants.DI_CHUYEN) {
        return Padding(
          padding: AppTheme.mainPadding.copyWith(top: 10, bottom: 10),
          child: CustomTextFormField(
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
            hintText: 'Nhập lý do khác...',
            maxLines: 5,
            controller: cancelOrderViewModel.cancelReasonCtl,
          ),
        );
      }
      return Expanded(
        child: SingleChildScrollView(
          child: Container(
            color: Palette.white,
            padding: AppTheme.mainPadding.copyWith(top: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...cancelOrderViewModel.lstReason.map((e) {
                  bool isSelected =
                      cancelOrderViewModel.reasonCancelSelected == e.id;
                  return Column(
                    children: [
                      renderItem(
                        title: e.content ?? '',
                        isSelected: isSelected,
                        onTap: () => cancelOrderViewModel.selectReason(e),
                      ),
                      BoxConst.s8,
                      const Divider(color: Palette.grey, height: 1),
                      BoxConst.s8,
                    ],
                  );
                }),
                renderOtherReason(cancelOrderViewModel),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget renderOtherReason(CancelOrderViewModel cancelOrderViewModel) {
    ReasonCancelOrderModel otherReasonCancel =
        cancelOrderViewModel.otherReasonCancel;
    bool isSelected =
        cancelOrderViewModel.reasonCancelSelected == otherReasonCancel.id;
    return Column(
      children: [
        renderItem(
          title: otherReasonCancel.content ?? '',
          isSelected: isSelected,
          onTap: () => cancelOrderViewModel.selectReason(otherReasonCancel),
        ),
        BoxConst.s8,
        CustomTextFormField(
          readOnly: !isSelected,
          contentPadding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
          hintText: 'Nhập lý do khác...',
          maxLines: 5,
          controller: cancelOrderViewModel.cancelReasonCtl,
        )
      ],
    );
  }

  Widget renderItem(
      {required String title, required bool isSelected, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (isSelected)
            Assets.svgs.radiusCheck.svg(width: 16.sp.sp, height: 16.sp.sp)
          else
            Assets.svgs.radiusUncheck.svg(width: 16.sp.sp, height: 16.sp.sp),
          BoxConst.s8,
          Expanded(
            child: Text(
              title,
              style: AppFont.t.s(13).w400.black,
            ),
          )
        ],
      ),
    );
  }
}
