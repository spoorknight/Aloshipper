import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../shared/button.dart';
import '../../../shared/text_form_field.dart';

class ModalUpdateInfo extends StatelessWidget {
  const ModalUpdateInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.transparent,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BoxConst.s8,
                  Text('Cập nhật tài khoản', style: AppFont.t.s(18).red),
                  const Divider(color: Palette.grey),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: AppTheme.mainPadding,
                      child: Row(
                        children: [
                          Container(
                            width: 0.6.sw,
                            height: 0.6.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                              border: Border.all(color: Palette.grey),
                            ),
                            child: const Icon(Icons.person, size: 30),
                          ),
                          BoxConst.s16,
                          Text(
                            'Đổi ảnh đại diện',
                            style: AppFont.t.red,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: RowContent2(
                      title: 'Tên đăng nhập',
                      child: Text(
                        'nguyenvana',
                        style: AppFont.t,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Họ và tên',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Số điện thoại',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Địa chỉ',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Email',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Mật khẩu',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  const Divider(color: Palette.grey),
                  const RowContent2(
                    title: 'Xác nhận mật khẩu',
                    child: CustomTextFormField(
                      height: 40,
                    ),
                  ),
                  BoxConst.s16,
                ],
              ),
            ),
          ),
          MyButton(title: 'Xác nhận', action: () {}),
        ],
      ),
    );
  }
}

class RowContent2 extends StatelessWidget {
  final String title;
  final Widget child;
  const RowContent2({
    Key? key,
    required this.title,
    required this.child,
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
              style: AppFont.t,
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
