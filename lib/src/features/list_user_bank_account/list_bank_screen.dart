import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../models/bank_model.dart';
import '../../navigator/app_navigator.dart';
import '../../shared/app_bar.dart';
import '../../shared/cache_image_network.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';
import '../payment/payment_view_model.dart';

class ListBankScreen extends StatelessWidget {
  const ListBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      bgColor: Palette.newLightGrey,
      appBar: MyAppBar(
        title: 'Chọn ngân hàng',
        backgroundColor: Palette.white,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: Consumer<PaymentViewModel>(builder: (context, viewModel, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              border: InputBorder.none,
              textAlignVertical: TextAlignVertical.center,
              prefixIcon: Icon(
                Icons.search,
                color: Palette.nuatral50,
                size: 18.w,
              ),
              hintText: 'Tìm kiếm',
              onChanged: (text) => viewModel.onSearchBanks(text),
            ),
            BoxConst.s8,
            const Divider(color: Palette.grey, height: 1),
            BoxConst.s8,
            Padding(
              padding: AppTheme.mainPadding,
              child: Text(
                'Danh sách ngân hàng',
                style: AppFont.t.s(14).w500.black,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            BoxConst.s8,
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 110 / 75,
                    mainAxisSpacing: 8.w,
                    crossAxisSpacing: 8.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.w,
                  ),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: viewModel.lstBanksSearch.length,
                  itemBuilder: (context, index) {
                    BankModel bankItem = viewModel.lstBanksSearch[index];
                    bool isSelected =
                        bankItem.id == (viewModel.bankSelected?.id ?? '');
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop(bankItem);
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 8.w),
                            decoration: AppTheme.boxDecoration.copyWith(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Palette.white,
                                border: Border.all(
                                    color: isSelected
                                        ? Palette.green00D566
                                        : Palette.white,
                                    width: 1)),
                            child: Column(
                              children: [
                                CachedNetworkImageCustom(
                                  url: bankItem.logo ?? '',
                                  width: 80.w,
                                  boxFit: BoxFit.contain,
                                ),
                                BoxConst.s4,
                                Text(
                                  bankItem.getShortName,
                                  style: AppFont.t.s(10).w500.black,
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                child: Assets.svgs.checkGreen
                                    .svg(width: 20.w, height: 20.w),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: viewModel.lstBanksSearch.length,
            //     itemBuilder: (context, index) {
            //       BankModel bankItem = viewModel.lstBanksSearch[index];
            //       return InkWell(
            //         onTap: () {
            //           Navigator.of(context).pop(bankItem);
            //         },
            //         child: Container(
            //           color: Palette.white,
            //           padding: EdgeInsets.only(top: 8.w),
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 16.w),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       decoration: BoxDecoration(
            //                         border: Border.all(
            //                             width: 0.4, color: Palette.nuatral50),
            //                         borderRadius: BorderRadius.circular(50.r),
            //                       ),
            //                       child: CachedNetworkImageCustom(
            //                         url: bankItem.logo ?? '',
            //                         width: 48.w,
            //                         height: 48.w,
            //                         boxFit: BoxFit.contain,
            //                       ),
            //                     ),
            //                     Box.s8,
            //                     Expanded(
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           Text(
            //                             bankItem.getShortName,
            //                             style: AppFont.t.s(14).w500,
            //                           ),
            //                           Box.s8,
            //                           Text(
            //                             bankItem.getName,
            //                             style: AppFont.t.s(13).w400,
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Box.s8,
            //               const Divider(color: Palette.grey, height: 1),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
