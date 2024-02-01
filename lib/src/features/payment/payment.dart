import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_shipper/src/features/payment/payment_view_model.dart';
import 'package:app_shipper/src/features/payment/sub_screen/nap_tien_dialog.dart';
import 'package:app_shipper/src/features/payment/sub_screen/withdraw_modal.dart';

import '../../configs/config.dart';
import '../../navigator/routes.dart';
import '../../shared/button.dart';
import '../../shared/text_form_field.dart';
import '../../utils/extensions/extensions.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PaymentViewModel>();
    return Container(
      padding: AppTheme.mainPadding,
      color: Palette.newLightGrey,
      child: Column(
        children: [
          BoxConst.s16,
          renderContentAccount(context, viewModel),
          BoxConst.s16,
          renderRowFuncBank(context),
        ],
      ),
    );
  }

  Widget renderRowFuncBank(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.listUserBankAccountScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
        decoration: AppTheme.boxDecoration.copyWith(
          color: Palette.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Assets.svgs.multiCreditCard.svg(width: 32.w, height: 32.w),
            BoxConst.s8,
            Text(
              'Quản lý ngân hàng rút tiền',
              style: AppFont.t.s(14).w500.black,
            )
          ],
        ),
      ),
    );
  }

  Widget renderRow({
    required String title,
    required Widget icon,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            icon,
            BoxConst.s8,
            Text(
              title,
              style: AppFont.t.s(13).w700.black,
            )
          ],
        ),
      ),
    );
  }

  Widget renderContentAccount(
      BuildContext context, PaymentViewModel viewModel) {
    bool showMoney = false;
    return StreamBuilder<ProfileModel?>(
        stream: appData.profile,
        builder: (context, snapshot) {
          final Item? account = snapshot.data?.item;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: AppTheme.boxDecoration.copyWith(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Palette.blue141C69.withOpacity(0.9),
                    Palette.redD31212.withOpacity(0.96),
                  ],
                )),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tổng số tiền',
                            style: AppFont.t.s(13).w400.white,
                          ),
                          IconButton(
                            icon: showMoney
                                ? const Icon(Icons.visibility_off,
                                color: Palette.grey)
                                : const Icon(Icons.visibility, color: Palette.grey),
                            onPressed: () {
                              setState(
                                    () {
                                  showMoney = !showMoney;
                                },
                              );
                            },
                          )
                        ],
                      ),
                      Text(
                        showMoney
                            ? account?.getUserAmount ?? '0'.toVnd
                            : '***********',
                        style: AppFont.t.s(20).w500.white,
                      ),
                      BoxConst.s8,
                      Text(
                        account?.getUserName ?? '',
                        style: AppFont.t.s(20).w500.white,
                      ),
                      BoxConst.s32,
                      renderBottom(context, viewModel),
                    ],
                  );
                }),
          );
        });
  }

  Widget renderBottom(BuildContext context, PaymentViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: MyButton(
            title: 'Nạp tiền',
            borderRadius: 8,
            color: Palette.white,
            titleStyle: AppFont.t.s(13).w400.black,
            icon: Assets.svgs.walletAddOutline.svg(width: 24, height: 24),
            action: () async {
              Navigator.of(context).pushNamed(Routes.depositScreen);
              // showModalBottomSheet(
              //   context: context,
              //   shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.vertical(
              //       top: Radius.circular(20),
              //     ),
              //   ),
              //   isScrollControlled: true,
              //   constraints: BoxConstraints(maxHeight: context.h() * 0.8),
              //   builder: (context) => ChangeNotifierProvider.value(
              //     value: viewModel,
              //     child: const AddFundsDialog(),
              //   ),
              // ).then((value) => viewModel.clearECnapTien());
            },
          ),
        ),
        BoxConst.s12,
        Expanded(
          child: MyButton.green(
            title: 'Rút tiền',
            borderRadius: 8,
            color: Palette.white,
            titleStyle: AppFont.t.s(13).w400.black,
            icon: Assets.svgs.bankOutline.svg(width: 24, height: 24),
            action: () async {
              await viewModel.getUserBanksInfo();
              if (viewModel.userBankAccountModel?.isHasData ?? false) {
                Navigator.of(context)
                    .pushNamed(Routes.withdrawByTransferScreen);
              } else {
                Navigator.of(context)
                    .pushNamed(Routes.listUserBankAccountScreen);
              }
            },
          ),
        ),
      ],
    );
  }
}


// class Payment extends StatelessWidget {
//   const Payment({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<PaymentViewModel>();
//     return Padding(
//       padding: AppTheme.mainPadding,
//       child: Column(
//         children: [
//           Box.s16,
//           StreamBuilder<ProfileModel?>(
//               stream: appData.profile,
//               builder: (context, profile) {
//                 return CustomTextFormField(
//                   title: 'Số dư',
//                   isPassword: true,
//                   centerTitle: true,
//                   inputType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   controller: TextEditingController(
//                       text: '${profile.data?.item?.user?.soDuTaiKhoan ?? '0'}'
//                           .toVnd),
//                   readOnly: true,
//                 );
//               }),
//           Box.s24,
//           Row(
//             children: [
//               Expanded(
//                 child: MyButton(
//                   title: 'Nạp tiền',
//                   borderRadius: 8,
//                   action: () {
//                     showModalBottomSheet(
//                       context: context,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(20),
//                         ),
//                       ),
//                       isScrollControlled: true,
//                       constraints: BoxConstraints(maxHeight: context.h() * 0.8),
//                       builder: (context) => ChangeNotifierProvider.value(
//                         value: viewModel,
//                         child: const AddFundsDialog(),
//                       ),
//                     ).then((value) => viewModel.clearECnapTien());
//                   },
//                 ),
//               ),
//               Box.s12,
//               Expanded(
//                 child: MyButton.green(
//                   title: 'Rút tiền',
//                   borderRadius: 8,
//                   action: () {
//                     showModalBottomSheet(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(20),
//                         ),
//                       ),
//                       context: context,
//                       isScrollControlled: true,
//                       constraints: BoxConstraints(maxHeight: context.h() * 0.9),
//                       builder: (modalTopup) {
//                         return ChangeNotifierProvider.value(
//                           value: viewModel,
//                           child: const WithdrawModal(),
//                         );
//                       },
//                     ).then((value) => viewModel.clear());
//                   },
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
