import 'package:flutter/material.dart';
import 'forget_password_view_model.dart';
import 'package:provider/provider.dart';

import '../../utils/extensions/extensions.dart';
import '../../configs/config.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ForgetPasswordViewModel>();
    return MyScaffold(
      appBar: const MyAppBar(title: 'Quên mật khẩu'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxConst.s24,
            Text(
              'Điền thông tin để tạo lại mật khẩu',
              style: AppFont.t.s(18),
            ),
            BoxConst.s20,
            CustomTextFormField(
              width: context.w() * 0.8,
              hintText: 'Email',
              prefixIcon: const Icon(Icons.email),
              controller: viewModel.emailController,
            ),
            BoxConst.s24,
            MyButton.rounded(
              title: 'Gửi',
              width: context.w() * 0.6,
              action: () => viewModel.forgetPassword(),
            ),
          ],
        ),
      ),
    );
  }
}
