import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../configs/app_constants.dart';
import '../../configs/config.dart';
import '../../navigator/routes.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/show_toast.dart';
import '../../shared/text_form_field.dart';
import '../../utils/app_enum.dart';
import '../payment/payment_view_model.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PaymentViewModel>();
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      appBar: const MyAppBar(
        title: 'Nạp tiền',
        backgroundColor: Palette.white,
      ),
      bottom: Padding(
        padding: AppTheme.mainPadding.copyWith(bottom: paddingBottomButton),
        child: MyButton.rounded(
          title: 'Nạp tiền',
          borderRadius: 8,
          action: () {
            int currentAmount = (int.tryParse(viewModel.amountController.text
                    .trim()
                    .replaceAll(',', '')) ??
                0);
            if (viewModel.amountController.text.trim().isNotEmpty &&
                (currentAmount >= 10000 && currentAmount <= 100000000)) {
              if (viewModel.paymentDeposit == PaymentDeposit.vnpay) {
                viewModel.napTien(
                    amount: viewModel.amountController.text.removeComma);
              }
              if (viewModel.paymentDeposit == PaymentDeposit.transfer) {
                Navigator.of(context)
                    .pushNamed(Routes.paymentInformationScreen, arguments: {
                  "amount": viewModel.amountController.text.removeComma,
                  "paymentMethod": viewModel.paymentDeposit,
                });
              }
            } else {
              ShowToast.error("Số tiền không hợp lệ");
            }
          },
        ),
      ),
      body: Column(
        children: [
          BoxConst.s16,
          renderInputAmount(context, viewModel),
          BoxConst.s36,
          renderPaymentMethod(viewModel),
        ],
      ),
    );
  }

  Widget renderPaymentMethod(PaymentViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phương thức thanh toán',
          style: AppFont.t.s(16).w700.black,
        ),
        BoxConst.s12,
        renderRowPaymentItem(
          icon: Assets.svgs.deposit.creditCard.svg(width: 56, height: 56),
          title: 'Chuyển khoản ngân hàng',
          subDescription: 'Chuyển từ tài khoản ngân hàng của bạn',
          isSelected: viewModel.paymentDeposit == PaymentDeposit.transfer,
          onTap: () => viewModel.onChangeDepositMethod(PaymentDeposit.transfer),
        ),
        BoxConst.s12,
        renderRowPaymentItem(
          icon: Assets.svgs.deposit.vnPay.svg(width: 40, height: 60),
          title: 'Cổng thanh toán',
          subDescription: 'Cổng thanh toán VNPAY',
          isSelected: viewModel.paymentDeposit == PaymentDeposit.vnpay,
          onTap: () => viewModel.onChangeDepositMethod(PaymentDeposit.vnpay),
        ),
      ],
    );
  }

  Widget renderRowPaymentItem({
    required Widget icon,
    required String title,
    required String subDescription,
    required bool isSelected,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: AppTheme.boxDecoration.copyWith(
          borderRadius: BorderRadius.circular(8),
          color: Palette.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  icon,
                  BoxConst.s8,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppFont.t.s(13).w700.black,
                        ),
                        Text(
                          subDescription,
                          style: AppFont.t.s(13).w400.nuatral50,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Assets.svgs.radiusCheck.svg(width: 20, height: 20)
            else
              Assets.svgs.radiusUncheck.svg(width: 20, height: 20),
          ],
        ),
      ),
    );
  }

  Widget renderInputAmount(BuildContext context, PaymentViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Số tiền cần nạp',
          style: AppFont.t.s(16).w700.black,
        ),
        BoxConst.s12,
        Container(
          decoration: AppTheme.boxDecoration.copyWith(
              borderRadius: BorderRadius.circular(8), color: Palette.white),
          child: CustomTextFormField(
              controller: viewModel.amountController,
              inputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              onChanged: (v) => viewModel.onChangeTextAmount(v),
              decoration: const InputDecoration()
                  .applyDefaults(
                      AppTheme.textFormFieldNonBorder(InputBorder.none))
                  .copyWith(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'đ',
                        style: AppFont.t.s(16).w500.black,
                      ),
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: double.infinity),
                    hintText: 'Nhập số tiền',
                  )),
        ),
        BoxConst.s12,
        Text(
          'Số tiền tối thiểu là 10,000đ',
          style: AppFont.t.s(13).w400.primary,
        ),
        BoxConst.s12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...viewModel.lstAmount.map((e) => InkWell(
                  onTap: () => viewModel.onSelectAmount(e),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: (context.w() / viewModel.lstAmount.length) -
                        (viewModel.lstAmount.length == 1 ? 32 : 16),
                    decoration: AppTheme.boxDecoration
                        .copyWith(borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      e.toVnd,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
