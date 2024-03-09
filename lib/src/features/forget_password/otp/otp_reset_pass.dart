import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

import '../../../configs/app_constants.dart';
import '../../../configs/config.dart';
import '../../../shared/app_bar.dart';
import '../../../shared/button.dart';
import '../../../shared/my_scaffold.dart';
import '../../../widgets/base_button_widget.dart';
import '../forget_password_view_model.dart';

class OTPResetPassScreen extends StatelessWidget {
  const OTPResetPassScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      onWillPop: () async {
        onWillPop(context);
        return Future(() => false);
      },
      appBar: MyAppBar(
        title: 'Xác thực mã OTP',
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () {
            onWillPop(context);
          },
        ),
      ),
      body: Column(
        children: [
          BoxConst.size(52),
          Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
            return Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text:
                          'Alotoday đã gửi cho bạn mã OTP xác thực đến số điện thoại ',
                      style: AppFont.t.s(13).w400.black,
                      children: [
                        TextSpan(
                          text: viewModel.phoneController.text,
                          style: AppFont.t.s(13).w600.black,
                        ),
                      ]),
                ],
              ),
            );
          }),
          BoxConst.size(25),
          Column(
            children: [
              renderInput(),
              renderErrorMess(),
              BoxConst.s12,
              renderOTPButton(),
            ],
          ),
          const Spacer(),
          BoxConst.s12,
          renderSubmitButton(),
          BoxConst.size(paddingBottomButton),
        ],
      ),
    );
  }

  onWillPop(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text.rich(
            TextSpan(
                text: 'Lưu ý: ',
                style: AppFont.t.s(13).w700.primary,
                children: [
                  TextSpan(
                    text:
                        'mỗi số điện thoại chỉ nhận xác thực OTP 3 lần 1 ngày!',
                    style: AppFont.t.s(13).w500.nuatral90,
                  ),
                ]),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Thoát',
                style: AppFont.t.s(13).w400.black,
              ),
            ),
            BaseButtonWidget(
              padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
              mainAxisSize: MainAxisSize.min,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
                color: Palette.primary,
              ),
              child: Text(
                'Tiếp tục',
                style: AppFont.t.s(13).w400.white,
              ),
              onTap: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget renderSubmitButton() {
    return Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
      return MyButton.rounded(
        color: viewModel.isActiveButton ? Palette.primary : Palette.grey,
        borderRadius: 8.r,
        title: 'Xác nhận',
        action: () {
          viewModel.checkValidOTP();
        },
      );
    });
  }

  Widget renderErrorMess() {
    return Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
      if (viewModel.errorOTPMess != null) {
        return Padding(
          padding: EdgeInsets.only(top: 16.sp),
          child: Text(
            viewModel.errorOTPMess!,
            style: AppFont.t
                .s(13)
                .w400
                .copyWith(color: Palette.primary.withOpacity(0.8)),
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget renderInput() {
    return Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
      return OTPTextField(
        controller: viewModel.otpController,
        length: 6,
        width: context.w() - 60.sp,
        fieldWidth: 30.w,
        style: AppFont.t.s(32).w500.primary,
        otpFieldStyle: OtpFieldStyle(
          enabledBorderColor: Palette.black,
          disabledBorderColor: Palette.black,
          focusBorderColor: Palette.black,
        ),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onChanged: (text) {
          viewModel.onChangedOTP(text);
        },
        onCompleted: (pin) {
          viewModel.onCompletedOTP(pin);
        },
      );
    });
  }

  Widget renderOTPButton() {
    return Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
      return StreamBuilder<int>(
        stream: viewModel.countdownController.stream,
        initialData: viewModel.timeCountDown,
        builder: (context, snapshot) {
          bool isCountDown =
              snapshot.hasData && snapshot.data != null && snapshot.data! > 0;

          return Column(
            children: [
              Text.rich(
                TextSpan(
                  text: 'Gửi lại OTP',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (!isCountDown) {
                        viewModel.reSendOTP();
                      }
                    },
                  style: AppFont.t.s(16).w500.primary.copyWith(
                        color: isCountDown
                            ? Palette.nuatral90.withOpacity(0.2)
                            : Palette.primary,
                      ),
                ),
              ),
              if (isCountDown) ...[
                BoxConst.s8,
                Text.rich(
                  TextSpan(
                      text: 'còn ',
                      style: AppFont.t.s(12).w400.primary,
                      children: [
                        TextSpan(
                          text: '(${snapshot.data}',
                          style: AppFont.t.s(12).w400.primary,
                        ),
                        TextSpan(
                          text: ' giây)',
                          style: AppFont.t.s(12).w400.primary,
                        ),
                      ]),
                ),
              ],
            ],
          );
        },
      );
    });
  }
}
