// ignore_for_file: use_build_context_synchronously

import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../navigator/app_navigator.dart';
import '../../../shared/button.dart';
import '../../../shared/show_toast.dart';
import '../../../shared/text_form_field.dart';
import '../payment_view_model.dart';

class Transfer extends StatelessWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PaymentViewModel>();

    return Scaffold(
      backgroundColor: Palette.transparent,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppTheme.mainPadding,
                child: Column(
                  children: [
                    BoxConst.s16,
                    CustomTextFormField(
                      controller: viewModel.soTienCkEC,
                      title: 'Nhập số tiền',
                      inputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                      onChanged: (v) {
                        final string = v.formatNumber;
                        viewModel.soTienCkEC.value = TextEditingValue(
                          text: string,
                          selection: TextSelection.collapsed(offset: string.length),
                        );
                      },
                    ),
                    BoxConst.s16,
                    CustomTextFormField(
                      title: 'Tên tài khoản',
                      controller: viewModel.nameEC,
                    ),
                    BoxConst.s16,
                    CustomTextFormField(
                      title: 'Số tài khoản',
                      controller: viewModel.accNumberNumberEC,
                      inputType: TextInputType.number,
                    ),
                    BoxConst.s16,
                    CustomTextFormField(
                      title: 'Ngân hàng',
                      controller: viewModel.bankNameEC,
                    ),
                    BoxConst.s16,
                    Text(
                      '* Có thể bạn bị trừ phí giao dịch do ngân hàng quy định',
                      style: AppFont.t,
                    ),
                  ],
                ),
              ),
            ),
          ),
          MyButton(
              title: 'Xác nhận',
              action: () async {
                if (viewModel.soTienCkEC.text.trim().isNotEmpty &&
                    viewModel.nameEC.text.trim().isNotEmpty &&
                    viewModel.accNumberNumberEC.text.trim().isNotEmpty &&
                    viewModel.bankNameEC.text.trim().isNotEmpty) {
                  if (await viewModel.rutTienChuyenKhoan()) {
                    AppNavigator.pop();
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
                                content: viewModel.soTienCkEC.text,
                              ),
                              _RowContent3(
                                title: 'Tên tài khoản',
                                content: viewModel.nameEC.text,
                              ),
                              _RowContent3(
                                title: 'Số tài khoản',
                                content: viewModel.accNumberNumberEC.text,
                              ),
                              _RowContent3(
                                title: 'Ngân hàng',
                                content: viewModel.bankNameEC.text,
                              ),
                              BoxConst.s16,
                              Text(
                                'Yêu cầu của bạn đang được xử lý.',
                                style: AppFont.t,
                              ),
                              BoxConst.s16,
                              const MyButton(title: 'Đóng', action: AppNavigator.pop)
                            ],
                          );
                        });
                  }
                } else {
                  ShowToast.error("Vui lòng không để trống các trường thông tin");
                }
              })
        ],
      ),
    );
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
