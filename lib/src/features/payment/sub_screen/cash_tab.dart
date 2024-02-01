// ignore_for_file: use_build_context_synchronously

import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../navigator/app_navigator.dart';
import '../../../navigator/routes.dart';
import '../../../shared/button.dart';
import '../../../shared/show_toast.dart';
import '../../../shared/text_form_field.dart';
import '../payment_view_model.dart';

class Cash extends StatelessWidget {
  const Cash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PaymentViewModel>();

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              BoxConst.s16,
              CustomTextFormField(
                controller: viewModel.idQuanEC,
                hintText: 'Nhập ID hoặc quét mã QR',
                width: context.w() * 0.7,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code),
                  onPressed: viewModel.scanQR,
                ),
              ),
              BoxConst.s16,
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  CustomTextFormField(
                    controller: viewModel.soTienMatEC,
                    hintText: 'Số tiền',
                    width: context.w() * 0.7,
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    onChanged: (v) {
                      final string = v.formatNumber;
                      viewModel.soTienMatEC.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                    },
                    maxLength: 15,
                  ),
                  Positioned(
                    right: 12.w,
                    child: Text(
                      'VNĐ',
                      style: AppFont.t.hint,
                    ),
                  )
                ],
              ),
              BoxConst.s24,
              MyButton(
                title: 'Xem điểm rút tiền mặt',
                borderRadius: 8,
                width: context.w() * 0.7,
                action: () {
                  const url =
                      'https://www.google.com/maps/d/u/1/viewer?fbclid=IwAR0_MUeGOGPpy2clxMAnYTZVXXZD9Cpfh5_WU2gMOFqDSEFLaVltR_wH3Nk&mid=1Q7knaGbEIJgp968XoMyK4IuR3icqj1A&ll=10.762632700000005%2C106.94847180000002&z=17';
                  viewModel.openLinkGoogleMaps(l: url);
                },
              ),
            ],
          ),
        ),
        MyButton(
            title: 'Xác nhận',
            action: () {
              if (viewModel.idQuanEC.text.trim().isNotEmpty &&
                  viewModel.soTienMatEC.text.trim().isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
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
                                  if (viewModel.passRutTienEC.text
                                      .trim()
                                      .isNotEmpty) {
                                    if (await viewModel.rutTienmat()) {
                                      AppNavigator.pop();
                                      showDialog(
                                          context: context,
                                          builder: (builder) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 32),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                        'Yêu cầu rút tiền thành công'),
                                                    BoxConst.s16,
                                                    MyButton(
                                                      title: 'Đóng',
                                                      borderRadius: 12,
                                                      width: context.w() * 0.7,
                                                      action: () {
                                                        AppNavigator.popUntil(
                                                            Routes.mainScreen);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }
                                  } else {
                                    ShowToast.error(
                                        "Vui lòng không để trống các trường thông tin");
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }).then((value) => viewModel.passRutTienEC.clear());
              } else {
                ShowToast.error("Vui lòng không để trống các trường thông tin");
              }
            })
      ],
    );
  }
}
