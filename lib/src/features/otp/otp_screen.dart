import 'dart:io';

import 'package:app_shipper/src/features/otp/otp_view_model.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../configs/app_constants.dart';
import '../../configs/config.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/my_scaffold.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    super.key,
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirm,
    required this.fullName,
    this.codeInvite,
  });

  final String phoneNumber;
  final String password;
  final String passwordConfirm;
  final String fullName;
  final String? codeInvite;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OTPViewModel>();
    return MyScaffold(
      appBar: const MyAppBar(title: 'Nhập mã OTP'),
      body: Column(
        children: [
          BoxConst.size(52),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text:
                        'Vui lòng nhập mã xác nhập OTP của bạn được gửi tới số điện thoại ',
                    style: AppFont.t.s(13).w400.black,
                    children: [
                      TextSpan(
                        text: phoneNumber,
                        style: AppFont.t.s(13).w600.black,
                      ),
                    ]),
              ],
            ),
          ),
          BoxConst.size(25),
          OTPTextField(
            controller: viewModel.otpController,
            length: 6,
            width: context.w() - 60.w,
            fieldWidth: 30.w,
            style: AppFont.t.s(32).w500,
            otpFieldStyle: OtpFieldStyle(
              enabledBorderColor: Palette.primary,
              disabledBorderColor: Palette.primary,
              focusBorderColor: Palette.primary,
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onChanged: (text) {
              viewModel.onChangedOTP(text);
            },
            onCompleted: (pin) {
              viewModel.onCompletedOTP(pin);
            },
          ),
          const Spacer(),
          renderOTPButton(viewModel),
          BoxConst.s12,
          MyButton.rounded(
            title: 'Xác nhận',
            width: context.w() - 32.w,
            action: viewModel.isActiveButton
                ? () => {
                      viewModel.submitForm(phoneNumber, password,
                          passwordConfirm, viewModel.otpValue, fullName, codeInvite)
                    }
                : null,
          ),
          BoxConst.size(paddingBottomButton),
        ],
      ),
    );
  }

  Widget renderOTPButton(viewModel) {
    return StreamBuilder<int>(
      stream: viewModel.countdownController.stream,
      initialData: viewModel.timeCountDown,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null && snapshot.data! > 0) {
          return Text.rich(
            TextSpan(
                text: 'Vui lòng chờ ',
                style: AppFont.t.s(13).w500.black,
                children: [
                  TextSpan(
                    text: '${snapshot.data}',
                    style: AppFont.t.s(16).w700.black,
                  ),
                  TextSpan(
                    text: ' giây',
                    style: AppFont.t.s(13).w500.black,
                  ),
                ]),
          );
        } else {
          return Text.rich(
            TextSpan(
              text: 'Gửi lại OTP',
              recognizer: TapGestureRecognizer()
                ..onTap = () => viewModel.sendOTP(phoneNumber),
              style: AppFont.t.s(13).w500.primary,
            ),
          );
        }
      },
    );
  }
}
