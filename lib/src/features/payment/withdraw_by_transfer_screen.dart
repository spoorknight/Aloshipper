import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import '../../shared/show_toast.dart';
import '../../shared/text_form_field.dart';
import 'payment_view_model.dart';

class WithdrawByTransferScreen extends StatelessWidget {
  const WithdrawByTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      bgColor: Palette.newLightGrey,
      appBar: MyAppBar(
        title: 'Rút tiền',
        backgroundColor: Palette.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: renderContent()),
          renderConfirmButton(),
        ],
      ),
    );
  }

  Widget renderContent() {
    return Consumer<PaymentViewModel>(builder: (context, viewModel, _) {
      return Column(
        children: [
          BoxConst.s12,
          Padding(
            padding: AppTheme.mainPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nhập số tiền bạn muốn rút',
                  style: AppFont.t.s(14).w700.nuatral90,
                ),
                BoxConst.s8,
                Container(
                  decoration: AppTheme.boxDecoration.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      color: Palette.white),
                  child: CustomTextFormField(
                      controller: viewModel.soTienCkEC,
                      inputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ThousandsSeparatorInputFormatter(),
                      ],
                      decoration: const InputDecoration()
                          .applyDefaults(
                              AppTheme.textFormFieldNonBorder(InputBorder.none))
                          .copyWith(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'đ',
                                style: AppFont.t.s(16).w500.nuatral50,
                              ),
                            ),
                            suffixIconConstraints: const BoxConstraints(
                                maxHeight: double.infinity),
                            hintText: 'Nhập số tiền',
                          )),
                ),
              ],
            ),
          ),
          Padding(
            padding: AppTheme.mainPadding.copyWith(top: 12.w, bottom: 12.w),
            child: Row(
              children: [
                Assets.svgs.checkedSuccess.svg(width: 20.w, height: 20.w),
                BoxConst.s8,
                Text(
                  'Số tiền tối thiểu 100.000đ một giao dịch',
                  style: AppFont.t.s(13).w700.green,
                ),
              ],
            ),
          ),
          if (viewModel.userBankAccountModel != null)
            renderCurrentBankAccount(context, viewModel),
        ],
      );
    });
  }

  Widget renderCurrentBankAccount(
      BuildContext context, PaymentViewModel viewModel) {
    BankModel currentBank = viewModel.lstBanks.firstWhere(
        (element) => element.id == viewModel.userBankAccountModel?.getBankId);
    return renderItemAccount(
      accountName: viewModel.userBankAccountModel?.getUserBankName ?? '',
      accountNumber: viewModel.userBankAccountModel?.getUserBankNumber ?? '',
      bankShortName: currentBank.getShortName,
      logo: currentBank.getLogo,
      onUpdate: () async {
        final res = await Navigator.of(context)
            .pushNamed(Routes.modifyBankAccountScreen, arguments: {
          'bankAccount': viewModel.userBankAccountModel?.data,
          'viewModel': viewModel,
        });

        if (res != null && res is bool && res == true) {
          viewModel.getUserBanksInfo();
        }
      },
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

  Widget renderConfirmButton() {
    return Padding(
      padding: AppTheme.mainPadding.copyWith(bottom: paddingBottomButton),
      child: Consumer<PaymentViewModel>(builder: (context, viewModel, _) {
        return MyButton.rounded(
            title: 'Xác nhận',
            borderRadius: 8,
            action: () async {
              if (viewModel.soTienCkEC.text.isEmpty ||
                  (viewModel.soTienCkEC.text.isNotEmpty &&
                      (double.tryParse(viewModel.soTienCkEC.text.removeComma) ??
                              0) <
                          100000)) {
                context.hideKeyboard;
                ShowToast.error("Vui lòng nhập số tiền hợp lệ");
                return;
              } else {
                final res = await checkPassword(context, viewModel);
                if (res) {
                  withdrawAmountToBank(
                      context, viewModel, viewModel.soTienCkEC.text.toVnd);
                }
              }
            });
      }),
    );
  }

  withdrawAmountToBank(
      BuildContext context, PaymentViewModel viewModel, String amount) {
    viewModel.rutTienChuyenKhoan().then((res) async {
      BankModel currentBank = viewModel.lstBanks.firstWhere(
          (element) => element.id == viewModel.userBankAccountModel!.getBankId);
      if (res) {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            builder: (builder) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BoxConst.s8,
                  Text(
                    'Thông tin thanh toán',
                    style: AppFont.t.s(18).red,
                  ),
                  const Divider(color: Palette.grey),
                  BoxConst.s16,
                  _RowContent3(
                    title: 'Số tiền',
                    content: amount,
                  ),
                  _RowContent3(
                    title: 'Tên tài khoản',
                    content: viewModel.userBankAccountModel!.getUserBankName,
                  ),
                  _RowContent3(
                    title: 'Số tài khoản',
                    content: viewModel.userBankAccountModel!.getUserBankNumber,
                  ),
                  _RowContent3(
                    title: 'Ngân hàng',
                    content: currentBank.getShortName,
                  ),
                  BoxConst.s16,
                  Text(
                    'Yêu cầu của bạn đang được xử lý.',
                    style: AppFont.t,
                  ),
                  BoxConst.s16,
                  MyButton(
                      title: 'Đóng',
                      action: () {
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      }
    });
  }

  checkPassword(BuildContext context, PaymentViewModel viewModel) {
    viewModel.passRutTienEC.text = '';
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: viewModel.passRutTienEC,
                    isPassword: true,
                    hintText: 'Nhập mật khẩu',
                    width: context.w() * 0.7,
                  ),
                  BoxConst.s16,
                  MyButton(
                    title: 'Xác nhận',
                    borderRadius: 12,
                    width: context.w() * 0.7,
                    action: () async {
                      /**
                       * kiểm tra mật khẩu đúng hay sai
                       * */
                      viewModel
                          .checkPassword(viewModel.passRutTienEC.text)
                          .then((value) async {
                        if (value) {
                          Navigator.of(context).pop(true);
                          return true;
                        } else {
                          EasyLoading.showError("Mật khẩu không chính xác");
                        }
                      });
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}

class _RowContent3 extends StatelessWidget {
  final String title;
  final String content;

  const _RowContent3({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.mainPadding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppFont.t.green,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              content,
              style: AppFont.t.s(16).red,
            ),
          ),
        ],
      ),
    );
  }
}
