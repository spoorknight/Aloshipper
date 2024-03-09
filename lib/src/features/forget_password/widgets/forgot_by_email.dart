part of '../forget_password_screen.dart';

class ForgotByEmail extends StatelessWidget {
  const ForgotByEmail({super.key});

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
                  width: context.w(),
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  controller: viewModel.emailController,
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
                  viewModel.forgetPasswordByEmail();
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Palette.primary,
                ),
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: Text(
                  'Gửi',
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
