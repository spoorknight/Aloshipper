import 'package:app_shipper/src/utils/extensions/context_extension.dart';
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
    final viewModel = context.watch<LoginViewModel>();
    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight),
            Assets.images.logo.image(
              width: context.w() / 2,
            ),
            BoxConst.s32,
            CustomTextFormField(
              hintText: 'Email hoặc tên đăng nhập',
              width: context.w() * 0.8,
              radius: 30,
              prefixIcon: const Icon(Icons.email),
              controller: viewModel.accountController,
            ),
            BoxConst.s16,
            CustomTextFormField(
              hintText: 'Mật khẩu',
              isPassword: true,
              width: context.w() * 0.8,
              radius: 30,
              prefixIcon: const Icon(Icons.lock),
              controller: viewModel.passwordController,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: viewModel.toggleRemember,
                    child: Row(
                      children: [
                        Checkbox(
                          value: viewModel.isRemember,
                          onChanged: (value) => viewModel.toggleRemember(),
                        ),
                        Text('Nhớ mật khẩu', style: AppFont.t)
                      ],
                    ),
                  ),
                  const Spacer(),
                  MyTextButton(
                    text: 'Quên mật khẩu?',
                    color: Palette.red,
                    alignment: Alignment.centerRight,
                    action: () =>
                        AppNavigator.push(Routes.forgetPasswordScreen),
                  ),
                ],
              ),
            ),
            MyButton.rounded(
              title: 'Đăng nhập',
              width: context.w() * 0.6,
              color: Palette.green,
              action: () {
                context.hideKeyboard;
                viewModel.login();
              },
            ),
            BoxConst.s4,
            MyTextButton(
              text: 'Bạn chưa có tài khoản?',
              action: () {},
            ),
            BoxConst.s4,
            MyButton.rounded(
              title: 'Đăng ký',
              width: context.w() * 0.6,
              action: () => AppNavigator.push(Routes.registerScreen),
            ),
          ],
        ),
      ),
    );
  }
}
