import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/app_constants.dart';
import '../../configs/config.dart';
import '../../models/bank_model.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/cache_image_network.dart';
import '../../shared/my_scaffold.dart';
import '../payment/payment_view_model.dart';

class ListUserBankAccountScreen extends StatelessWidget {
  const ListUserBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      bgColor: Palette.newLightGrey,
      appBar: MyAppBar(
        title: 'Tài khoản ngân hàng',
        backgroundColor: Palette.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: renderContent(),
    );
  }

  Widget renderItemAccount({
    String? logo,
    required String accountName,
    required String accountNumber,
    required String bankShortName,
    Function()? onTap,
    Function()? onUpdate,
  }) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: AppTheme.mainPadding,
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
          decoration: AppTheme.boxDecoration.copyWith(
            borderRadius: BorderRadius.circular(8.r),
            color: Palette.white,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Palette.whiteEEF2F3,
                  border: Border.all(width: 0.4, color: Palette.whiteEEF2F3),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: CachedNetworkImageCustom(
                  url: logo,
                  width: 48.w,
                  height: 48.w,
                  boxFit: BoxFit.contain,
                ),
              ),
              BoxConst.s8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accountName,
                      style: AppFont.t.s(14).w500,
                    ),
                    BoxConst.s8,
                    Row(
                      children: [
                        Text(
                          bankShortName,
                          style: AppFont.t.s(13).w400.nuatral50,
                        ),
                        Container(
                          height: 10.w,
                          width: 1.w,
                          color: Palette.nuatral50,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                        ),
                        Text(
                          accountNumber,
                          style: AppFont.t.s(13).w400.nuatral50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BoxConst.s8,
              InkWell(
                onTap: onUpdate,
                child: Text(
                  'Thay đổi',
                  style: AppFont.t.s(13).w400.linkBlue,
                ),
              )
            ],
          ),
        ));
  }

  Widget renderContent() {
    return Consumer<PaymentViewModel>(builder: (context, viewModel, _) {
      if (viewModel.userBankAccountModel?.isHasData ?? false) {
        BankModel? currentBank = (viewModel.lstBanks).firstWhere((element) =>
            element.id == viewModel.userBankAccountModel!.getBankId);

        return Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  BoxConst.s12,
                  if (currentBank != null)
                    renderItemAccount(
                      accountName:
                          viewModel.userBankAccountModel!.getUserBankName,
                      accountNumber:
                          viewModel.userBankAccountModel!.getUserBankNumber,
                      logo: currentBank.getLogo,
                      bankShortName: currentBank.getShortName,
                      onUpdate: () async {
                        final res = await Navigator.of(context).pushNamed(
                            Routes.modifyBankAccountScreen,
                            arguments: {
                              'bankAccount':
                                  viewModel.userBankAccountModel!.data,
                              'viewModel': viewModel,
                            });

                        if (res != null && res is bool && res == true) {
                          viewModel.getUserBanksInfo();
                        }
                      },
                    ),
                  BoxConst.s8,
                  Padding(
                    padding: AppTheme.mainPadding,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Palette.linkBlue,
                        ),
                        BoxConst.s8,
                        Text(
                          'Bạn chỉ được thêm tối đa 1 tài khoản ngân hàng.',
                          style: AppFont.t.s(13).w400.linkBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            renderConfirmButton(context, viewModel),
          ],
        );
      }
      return Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Assets.svgs.pana.svg(width: 320.w),
                BoxConst.s8,
                Text(
                  'Bạn chưa có tài khoản ngân hàng nào\nVui lòng thêm tài khoản ngân hàng để tiếp tục',
                  style: AppFont.t.s(13).w400,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          renderCreateButton(context, viewModel),
        ],
      );
    });
  }

  Widget renderConfirmButton(BuildContext context, PaymentViewModel viewModel) {
    return Padding(
      padding: AppTheme.mainPadding.copyWith(bottom: paddingBottomButton),
      child: MyButton.rounded(
          title: 'Xác nhận',
          borderRadius: 8,
          action: () {
            AppNavigator.pop();
          }),
    );
  }

  Widget renderCreateButton(BuildContext context, PaymentViewModel viewModel) {
    return Padding(
      padding: AppTheme.mainPadding.copyWith(bottom: paddingBottomButton),
      child: MyButton.rounded(
          title: 'Thêm ngân hàng',
          borderRadius: 8,
          action: () async {
            final res = await Navigator.of(context).pushNamed(
                Routes.modifyBankAccountScreen,
                arguments: {'viewModel': viewModel});
            if (res != null && res is bool && res == true) {
              viewModel.getUserBanksInfo();
            }
          }),
    );
  }
}
