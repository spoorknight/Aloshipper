import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';
import '../../../navigator/app_navigator.dart';
import '../../../shared/app_bar.dart';
import '../../../shared/my_scaffold.dart';
import '../../../shared/show_toast.dart';
import '../../../shared/text_field/text_form_field.dart';
import '../../../utils/helpers/validators.dart';
import '../../../widgets/base_button_widget.dart';
import '../forget_password_view_model.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: MyAppBar(
        title: 'Cập nhật mật khẩu',
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      bottom: renderBtnConfirm(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxConst.s8,
            Text.rich(
              TextSpan(
                text: 'Vui lòng cập nhật lại mật khẩu để tiếp tục trải nghiệm ',
                style: AppFont.t.s(13).w400.black,
                children: [
                  TextSpan(
                    text: 'Alo Today',
                    style: AppFont.t.s(16).w500.primary,
                  ),
                ],
              ),
            ),
            BoxConst.s24,
            Text(
              'Nhập mật khẩu',
              style: AppFont.t.s(16).w500.nuatral90,
            ),
            BoxConst.s8,
            Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
              return CustomTextFormField(
                hintText: 'Nhập mật khẩu',
                isPassword: true,
                controller: viewModel.passController,
                validator: (text) {
                  if (Validator.isPassword(text ?? '')) {
                    return null;
                  }
                  return 'Mật khẩu không hợp lệ';
                },
              );
            }),
            BoxConst.s24,
            Text(
              'Nhập lại mật khẩu',
              style: AppFont.t.s(16).w500.nuatral90,
            ),
            BoxConst.s8,
            Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
              return CustomTextFormField(
                hintText: 'Nhập mật khẩu',
                isPassword: true,
                controller: viewModel.confirmPassController,
              );
            }),
            BoxConst.s8,
            renderRules(),
          ],
        ),
      ),
    );
  }

  Widget renderBtnConfirm() {
    return Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: BaseButtonWidget(
          onTap: () {
            context.hideKeyboard;
            if (viewModel.getPass == viewModel.getConfirmPass) {
              viewModel.forgotPasswordWithOTP();
            } else {
              ShowToast.error('Mật khẩu xác nhận không khớp');
            }
          },
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Palette.primary,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 16.sp),
          child: Text(
            'Tiếp tục',
            style: AppFont.t.s(16).w700.white,
          ),
        ),
      );
    });
  }

  Widget renderRules() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.info_rounded,
              size: 24.sp,
              color: Palette.greyA9A9A9,
            ),
            BoxConst.s8,
            Text(
              'Tối thiểu có 8 ký tự',
              style: AppFont.t.s(13).w400.greyA9A9A9,
            ),
          ],
        ),
        BoxConst.s8,
        Row(
          children: [
            Icon(
              Icons.info_rounded,
              size: 24.sp,
              color: Palette.greyA9A9A9,
            ),
            BoxConst.s8,
            Text(
              'Có chữ thường (a-z) và chữ in hoa (A-Z)',
              style: AppFont.t.s(13).w400.greyA9A9A9,
            ),
          ],
        ),
        BoxConst.s8,
        Row(
          children: [
            Icon(
              Icons.info_rounded,
              size: 24.sp,
              color: Palette.greyA9A9A9,
            ),
            BoxConst.s8,
            Text(
              'Có ít nhất một số (0-9) hoặc ký hiệu (@#)',
              style: AppFont.t.s(13).w400.greyA9A9A9,
            ),
          ],
        ),
        BoxConst.s8,
      ],
    );
  }
}
