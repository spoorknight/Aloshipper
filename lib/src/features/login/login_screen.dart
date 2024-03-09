import 'package:app_shipper/src/shared/bottom_rule.dart';
import 'package:app_shipper/src/shared/text_field/base_text_form_field.dart';
import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../shared/button.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';
import '../../utils/extensions/extensions.dart';
import 'login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<LoginViewModel>();
    // return MyScaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         const SizedBox(height: kToolbarHeight),
    //         Assets.images.logo.image(
    //           width: context.w() / 2,
    //         ),
    //         BoxConst.s32,
    //         CustomTextFormField(
    //           hintText: 'Email hoặc tên đăng nhập',
    //           width: context.w() * 0.8,
    //           radius: 30,
    //           prefixIcon: const Icon(Icons.email),
    //           controller: viewModel.accountController,
    //         ),
    //         BoxConst.s16,
    //         CustomTextFormField(
    //           hintText: 'Mật khẩu',
    //           isPassword: true,
    //           width: context.w() * 0.8,
    //           radius: 30,
    //           prefixIcon: const Icon(Icons.lock),
    //           controller: viewModel.passwordController,
    //         ),
    //         Container(
    //           padding: EdgeInsets.symmetric(horizontal: 25.w),
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               InkWell(
    //                 onTap: viewModel.toggleRemember,
    //                 child: Row(
    //                   children: [
    //                     Checkbox(
    //                       value: viewModel.isRemember,
    //                       onChanged: (value) => viewModel.toggleRemember(),
    //                     ),
    //                     Text('Nhớ mật khẩu', style: AppFont.t)
    //                   ],
    //                 ),
    //               ),
    //               const Spacer(),
    //               MyTextButton(
    //                 text: 'Quên mật khẩu?',
    //                 color: Palette.red,
    //                 alignment: Alignment.centerRight,
    //                 action: () =>
    //                     AppNavigator.push(Routes.forgetPasswordScreen),
    //               ),
    //             ],
    //           ),
    //         ),
    //         MyButton.rounded(
    //           title: 'Đăng nhập',
    //           width: context.w() * 0.6,
    //           color: Palette.green,
    //           action: () {
    //             context.hideKeyboard;
    //             viewModel.login();
    //           },
    //         ),
    //         BoxConst.s4,
    //         MyTextButton(
    //           text: 'Bạn chưa có tài khoản?',
    //           action: () {},
    //         ),
    //         BoxConst.s4,
    //         MyButton.rounded(
    //           title: 'Đăng ký',
    //           width: context.w() * 0.6,
    //           action: () => AppNavigator.push(Routes.registerScreen),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    final viewModel = context.watch<LoginViewModel>();
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      appBar: AppBar(
        foregroundColor: Palette.background,
        elevation: 0,
        backgroundColor: Palette.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.svgs.waitingLogin.svg(width: 335.w, height: 231.w),
                  BoxConst.s32,
                  BaseTextFormField(
                    radius: 8.r,
                    controller: viewModel.accountController,
                    prefixIcon: Icon(
                      Icons.smartphone_outlined,
                      color: Palette.grey,
                      size: 18.sp,
                    ),
                    title: 'Số điện thoại',
                    hintText: 'Nhập số điện thoại',
                  ),
                  BoxConst.s16,
                  BaseTextFormField(
                    hintText: 'Nhập mật khẩu',
                    title: 'Mật khẩu',
                    isPassword: true,
                    radius: 8.r,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Palette.grey,
                      size: 18.sp,
                    ),
                    controller: viewModel.passwordController,
                  ),
                  BoxConst.s16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: viewModel.toggleRemember,
                        child: Row(
                          children: [
                            Checkbox(
                              value: viewModel.isRemember,
                              onChanged: (value) => viewModel.toggleRemember(),
                            ),
                            Text('Nhớ mật khẩu',
                                style: AppFont.t.s(13).w400.black)
                          ],
                        ),
                      ),
                      const Spacer(),
                      MyTextButton(
                        text: 'Quên mật khẩu?',
                        color: Palette.red,
                        alignment: Alignment.centerRight,
                        style: AppFont.t.s(13).w700.primary,
                        action: () =>
                            AppNavigator.push(Routes.forgetPasswordScreen),
                      ),
                    ],
                  ),
                  BoxConst.size(50),
                  MyButton.rounded(
                    title: 'Đăng nhập',
                    borderRadius: 8.r,
                    width: 255.w,
                    color: Palette.primary,
                    action: () {
                      context.hideKeyboard;
                      viewModel.login();
                    },
                  ),
                  BoxConst.s16,
                  Text.rich(
                    TextSpan(
                      text: 'Bạn chưa có tài khoản? ',
                      style: AppFont.t.s(16).w400.black,
                      children: [
                        TextSpan(
                          text: 'Đăng ký',
                          style: AppFont.t.s(16).w700.primary,
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => AppNavigator.push(Routes.registerScreen),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const BottomRuleWidget(),
        ],
      ),
    );
  }
}
