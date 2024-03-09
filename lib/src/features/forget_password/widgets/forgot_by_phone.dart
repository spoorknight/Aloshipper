part of '../forget_password_screen.dart';

class ForgotByPhone extends StatelessWidget {
  const ForgotByPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxConst.s24,
              Text(
                'Điền thông tin để tạo lại mật khẩu',
                style: AppFont.t.s(16).w500.nuatral90,
              ),
              BoxConst.s8,
              Consumer<ForgetPasswordViewModel>(
                  builder: (context, viewModel, _) {
                return CustomTextFormField(
                  hintText: 'Số điện thoại',
                  prefixIcon: const Icon(Icons.phone_android_outlined),
                  controller: viewModel.phoneController,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  validator: (text) {
                    if (Validator.isValidPhoneNumber(text ?? "")) {
                      return null;
                    }
                    return 'Số điện thoại không hợp lệ';
                  },
                );
              }),
            ],
          ),
        ),
        Column(
          children: [
            Text.rich(
              TextSpan(
                text: 'Bạn đã có tài khoản? ',
                style: AppFont.t,
                children: [
                  TextSpan(
                    text: 'Đăng nhập',
                    recognizer: TapGestureRecognizer()
                      ..onTap = AppNavigator.pop,
                    style: AppFont.t.w700.red,
                  ),
                ],
              ),
            ),
            BoxConst.s4,
            Consumer<ForgetPasswordViewModel>(builder: (context, viewModel, _) {
              return BaseButtonWidget(
                onTap: () {
                  if (Validator.isValidPhoneNumber(
                      viewModel.phoneController.text.trim())) {
                    viewModel.forgetPasswordByPhoneNum();
                  }
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Palette.primary,
                ),
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: Text(
                  'Tiếp tục',
                  style: AppFont.t.s(16).w700.white,
                ),
              );
            }),
            BoxConst.size(paddingBottomButton),
          ],
        ),
      ],
    );
  }
}
