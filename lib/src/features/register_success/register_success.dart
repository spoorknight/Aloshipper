import 'dart:io';

import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:flutter/material.dart';

import '../../configs/config.dart';
import '../../navigator/routes.dart';
import '../../shared/button.dart';
import '../../shared/my_scaffold.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({super.key, this.message, this.title});

  final String? message;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MyScaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoxConst.size(100),
            Assets.svgs.imgSuccess.svg(width: 170.w, height: 170.w),
            BoxConst.size(33),
            Text(
              title ?? 'Chúc mừng',
              style: AppFont.t.s(28).w700.black,
            ),
            BoxConst.s12,
            Text(
              message ?? 'Bạn đã đăng ký thành công',
              style: AppFont.t.s(18).w500.black,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            MyButton.rounded(
              title: 'Trở lại',
              borderRadius: 8.r,
              action: () {
                AppNavigator.popUntil(Routes.loginScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
