import 'package:app_shipper/src/configs/app_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../configs/config.dart';

class BottomRuleWidget extends StatelessWidget {
  const BottomRuleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.sp),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: 'Tôi đồng ý với điều kiện và điều khoản sử dụng của ',
          style: AppFont.t.s(13).w400.black,
          children: [
            TextSpan(
              text: 'AloToday',
              style: AppFont.t.s(16).w700.primary,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrlString(
                    AppConstants.linkDieuKhoan,
                    mode: LaunchMode.externalApplication,
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
