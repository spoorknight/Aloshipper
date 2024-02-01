import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_constants.dart';
import '../../../configs/config.dart';

class RulesWidget extends StatelessWidget {
  const RulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
            text:
                'Bằng cách tham gia vào các hoạt động thưởng, bạn đã đồng ý với ',
            style: AppFont.t.s(11).w400.nuatral90,
            children: [
              TextSpan(
                text: 'Điều khoản ',
                style: AppFont.t.s(11).w700.error,
                recognizer: TapGestureRecognizer()..onTap = () {
                  launchUrlString(
                    AppConstants.linkDieuKhoan,
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
              TextSpan(
                text: 'của chúng tôi',
                style: AppFont.t.s(11).w400.nuatral90,
              ),
            ]),
      ),
    );
  }
}
