import 'package:app_shipper/src/configs/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../models/bank_model.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/cache_image_network.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';
import '../payment/payment_view_model.dart';

class ModifyBankAccountScreen extends StatelessWidget {
  const ModifyBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      bgColor: Palette.newLightGrey,
      appBar: MyAppBar(
        title: 'Thêm khoản ngân hàng',
        backgroundColor: Palette.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<PaymentViewModel>(builder: (context, viewModel, _) {
              return Padding(
                padding: AppTheme.mainPadding,
                child: Column(
                  children: [
                    BoxConst.s12,
                    InkWell(
                      onTap: () async {
                        final res = await Navigator.of(context)
                            .pushNamed(Routes.listBankScreen, arguments: {'viewModel': viewModel});
                        if (res != null && res is BankModel) {
                          viewModel.setBankSelected(res);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.w, horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: Palette.white,
                            border:
                                Border.all(width: 1, color: Palette.nuatral50),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.4, color: Palette.whiteEEF2F3),
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: Palette.whiteEEF2F3,
                                    ),
                                    child: viewModel.bankSelected != null
                                        ? CachedNetworkImageCustom(
                                            url:
                                                viewModel.bankSelected!.getLogo,
                                            width: 48.w,
                                            height: 48.w,
                                            boxFit: BoxFit.contain,
                                          )
                                        : Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Assets.svgs.bank.svg(
                                              width: 20.w,
                                              height: 20.w,
                                            ),
                                        ),
                                  ),
                                  BoxConst.s8,
                                  if (viewModel.bankSelected == null)
                                    Text(
                                      'Chọn ngân hàng hàng',
                                      style: AppFont.t.s(14).w500.nuatral50,
                                    )
                                  else
                                    Text(
                                      viewModel.bankSelected!.getShortName,
                                      style: AppFont.t.s(14).w500.black,
                                    ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Palette.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    BoxConst.s24,
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w)
                              .copyWith(bottom: 0),
                      decoration: BoxDecoration(
                          color: Palette.white,
                          border:
                              Border.all(width: 1, color: Palette.nuatral50),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Số tài khoản ngân hàng',
                            style: AppFont.t.s(13).w400.nuatral90,
                          ),
                          CustomTextFormField(
                              controller: viewModel.accountNumberController,
                              decoration: const InputDecoration()
                                  .applyDefaults(
                                      AppTheme.textFormFieldNonBorder(
                                          InputBorder.none))
                                  .copyWith(
                                    hintText: 'Nhập số tài khoản của bạn',
                                    contentPadding: EdgeInsets.zero,
                                  )),
                        ],
                      ),
                    ),
                    BoxConst.s8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Palette.linkBlue,
                        ),
                        BoxConst.s8,
                        Expanded(
                          child: Text(
                            'Nhập và kiểm tra số tài khoản ngân hàng chính xác để đảm bảo tiền được rút về đúng tài khoản của bạn',
                            style: AppFont.t.s(13).w400.linkBlue,
                          ),
                        ),
                      ],
                    ),
                    BoxConst.s24,
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w)
                              .copyWith(bottom: 0),
                      decoration: BoxDecoration(
                          color: Palette.white,
                          border:
                              Border.all(width: 1, color: Palette.nuatral50),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tên chủ tài khoản',
                            style: AppFont.t.s(13).w400.nuatral90,
                          ),
                          CustomTextFormField(
                              controller: viewModel.accountNameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                                // Đảm bảo chỉ một dòng
                                UppercaseTextInputFormatter(),
                                // Áp dụng viết hoa tự động
                                UnSignTextInputFormatter(),
                                // // Áp dụng bo ky tu
                              ],
                              decoration: const InputDecoration()
                                  .applyDefaults(
                                      AppTheme.textFormFieldNonBorder(
                                          InputBorder.none))
                                  .copyWith(
                                    hintText: 'Nhập tên tài khoản của bạn',
                                    contentPadding: EdgeInsets.zero,
                                  )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          renderButtonBottom(),
        ],
      ),
    );
  }

  Widget renderButtonBottom() {
    return Padding(
      padding: AppTheme.mainPadding.copyWith(bottom: paddingBottomButton),
      child: Consumer<PaymentViewModel>(builder: (context, viewModel, _) {
        return MyButton.rounded(
            title: 'Xác nhận',
            borderRadius: 8,
            action: () => viewModel.submitBankAccount());
      }),
    );
  }
}
