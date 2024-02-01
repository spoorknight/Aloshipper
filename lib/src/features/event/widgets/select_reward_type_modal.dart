import 'package:flutter/material.dart';

import '../../../configs/config.dart';
import '../../../utils/app_enum.dart';

class SelectRewardTypeModal extends StatelessWidget {
  final Function? action;

  const SelectRewardTypeModal({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Palette.bgColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        width: MediaQuery.of(context).size.width / 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chọn phần thưởng',
              style: AppFont.t.s(16).w700.black,
              textAlign: TextAlign.center,
            ),
            BoxConst.s16,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (action != null) {
                        Navigator.of(context).pop();
                        action!(GiftType.point);
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 90.w,
                          height: 90.w,
                          padding: EdgeInsets.symmetric(
                              vertical: 21.w, horizontal: 21.w),
                          decoration: AppTheme.boxDecoration.copyWith(
                            color: Palette.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Assets.svgs.coin.svg(),
                        ),
                        BoxConst.s8,
                        Text(
                          'Điểm thưởng',
                          style: AppFont.t.s(13).w400.black,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (action != null) {
                        action!(GiftType.day);
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 90.w,
                          height: 90.w,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.w, horizontal: 10.w),
                          decoration: AppTheme.boxDecoration.copyWith(
                            color: Palette.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Assets.svgs.hourglass.svg(),
                        ),
                        BoxConst.s8,
                        Text(
                          'Thời gian sử dụng',
                          style: AppFont.t.s(13).w400.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
