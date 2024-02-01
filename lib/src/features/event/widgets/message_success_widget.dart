import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../shared/button.dart';

class MessageSuccessWidget extends StatelessWidget {
  const MessageSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.svgs.kingSc.svg(width: 124.w, height: 129.w),
            BoxConst.s12,
            Assets.svgs.congratulationsText.svg(width: 272.w),
            BoxConst.s8,
            Text(
              'Bạn vừa đổi thành công điểm thưởng! Đừng dừng lại ở đây - những phần quà lớn hơn đang chờ đợi bạn phía trước',
              style: AppFont.t.s(13).w500.nuatral90,
              textAlign: TextAlign.center,
            ),
            BoxConst.s32,
            MyButton.rounded(
              title: 'Tiếp tục săn thưỏng',
              borderRadius: 8.r,
              titleStyle: AppFont.t.s(14).w700.white,
              action: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
