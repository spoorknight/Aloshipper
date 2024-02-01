import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';
import '../../../di/injection/injection.dart';
import '../../../navigator/app_navigator.dart';
import '../../../navigator/routes.dart';
import '../../../shared/button.dart';
import '../../../shared/cache_image_network.dart';
import '../../../shared/show_toast.dart';
import '../../../shared/text_content/row_content.dart';
import '../../../shared/text_form_field.dart';
import '../payment_view_model.dart';

class AddFundsDialog extends StatefulWidget {
  const AddFundsDialog({super.key});

  @override
  State<AddFundsDialog> createState() => _AddFundsDialogState();
}

class _AddFundsDialogState extends State<AddFundsDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PaymentViewModel>();

    return SafeArea(
      child: Column(
        children: [
          BoxConst.s8,
          Text('Nạp tiền', style: AppFont.t.s(18).red),
          const Divider(color: Palette.grey),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Palette.grey,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Palette.transparent,
              labelStyle: AppFont.t.underline,
              unselectedLabelStyle: AppFont.t,
              labelColor: Palette.red,
              unselectedLabelColor: Palette.black,
              tabs: [
                ChangeNotifierProvider.value(
                  value: viewModel,
                  child: const Tab(child: Text('Chuyển khoản')),
                ),
                ChangeNotifierProvider.value(
                  value: viewModel,
                  child: const Tab(child: Text('VNPAY')),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _chuyenKhoan(viewModel),
                _vnpay(viewModel),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _vnpay(PaymentViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: MyButton(
            borderRadius: 8,
            title: 'Xác nhận',
            action: () {
              if (viewModel.soTienVnpayEC.text.trim().isNotEmpty) {
                AppNavigator.pop();
                viewModel.napTien();
              } else {
                ShowToast.error("Vui lòng không để trống các trường thông tin");
              }
            },
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BoxConst.s16,
            Assets.images.vnpay.image(width: 200.w),
            BoxConst.s16,
            CustomTextFormField(
              controller: viewModel.soTienVnpayEC,
              title: "Số tiền",
              hintText: 'Số tiền cần nạp',
              inputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              onChanged: (v) {
                final string = v.formatNumber;
                viewModel.soTienVnpayEC.value = TextEditingValue(
                  text: string,
                  selection: TextSelection.collapsed(offset: string.length),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _chuyenKhoan(PaymentViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: MyButton(
            borderRadius: 8,
            title: 'Tạo QR Code',
            action: () {
              if (viewModel.soTienQREC.text.trim().isNotEmpty) {
                viewModel.getInfoPayment();
              } else {
                ShowToast.error("Vui lòng không để trống các trường thông tin");
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BoxConst.s8,
              Assets.images.logoMb.image(),
              if (viewModel.bankInfo == null) ...[
                BoxConst.s8,
                Text(
                  'Vui lòng nhập số tiền cần chuyển khoản để tạo QRCode',
                  style: AppFont.t,
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                BoxConst.s8,
                InkWell(
                  onTap: () {
                    AppNavigator.push(Routes.qrDetail,
                        arguments: viewModel.imageQR);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Palette.hint),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: CachedNetworkImageCustom(
                      url: viewModel.imageQR,
                      height: 170.h,
                      width: 170.w,
                    ),
                  ),
                ),
                BoxConst.s8,
                RowContent(
                  styleContent: AppFont.t.w700.blue,
                  showCopy: true,
                  title: 'Chủ TK:',
                  content: viewModel.bankInfo?.data?.accountOwner,
                ),
                BoxConst.s8,
                RowContent(
                  styleContent: AppFont.t.w700.blue,
                  showCopy: true,
                  title: 'Tên ngân hàng:',
                  content: viewModel.bankInfo?.data?.bankName,
                ),
                BoxConst.s8,
                RowContent(
                  styleContent: AppFont.t.w700.blue,
                  showCopy: true,
                  title: 'Số TK:',
                  content: viewModel.bankInfo?.data?.bankNum,
                ),
                BoxConst.s8,
                RowContent(
                  styleContent: AppFont.t.w700.blue,
                  showCopy: true,
                  title: 'Số tiền:',
                  content: viewModel.soTienQREC.text,
                ),
                BoxConst.s8,
                RowContent(
                  styleContent: AppFont.t.w700.blue,
                  showCopy: true,
                  title: 'Nội dung CK:',
                  content: 'NAP${appData.profile.value?.item?.user?.id}',
                ),
              ],
              BoxConst.s16,
              CustomTextFormField(
                controller: viewModel.soTienQREC,
                hintText: 'Số tiền cần nạp',
                title: "Số tiền",
                focusNode: viewModel.soTienQrNode,
                inputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                onChanged: (v) {
                  final string = v.formatNumber;
                  viewModel.soTienQREC.value = TextEditingValue(
                    text: string,
                    selection: TextSelection.collapsed(offset: string.length),
                  );
                },
              ),
              SizedBox(height: 70.h),
            ],
          ),
        ),
      ),
    );
  }
}
