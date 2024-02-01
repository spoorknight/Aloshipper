import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/shared/app_bar.dart';
import 'package:app_shipper/src/shared/my_scaffold.dart';
import 'package:flutter/material.dart';

class InfoUserDriveScreen extends StatelessWidget {
  const InfoUserDriveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      appBar: const MyAppBar(
          title: 'Thời gian hoạt động', backgroundColor: Palette.white),
      body: appData.userInfoActiveModel?.isEnoughTime ?? false
          ? renderSuccess()
          : renderInfoDrive(),
    );
  }

  Widget renderSuccess() {
    return Column(
      children: [BoxConst.s8, Assets.svgs.successDrive.svg(width: 400.w)],
    );
  }

  Widget renderInfoDrive() {
    return Column(
      children: [
        BoxConst.s12,
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: AppTheme.boxDecoration.copyWith(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng thời gian hoạt động',
                style: AppFont.t.s(16).w500.black,
              ),
              Text(
                '${appData.userInfoActiveModel?.getTotalHoursSetting ?? 0}h',
                style: AppFont.t.s(16).w500.black,
              ),
            ],
          ),
        ),
        BoxConst.s12,
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: AppTheme.boxDecoration.copyWith(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thời gian hoạt động của bạn',
                style: AppFont.t.s(16).w500.black,
              ),
              Text(
                '${appData.userInfoActiveModel?.getTotalHoursShipper ?? 0}h',
                style: AppFont.t.s(16).w500.green,
              ),
            ],
          ),
        ),
        BoxConst.s12,
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          decoration: AppTheme.boxDecoration.copyWith(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bạn cần hoạt động thêm',
                    style: AppFont.t.s(16).w500.black,
                  ),
                  Text(
                    '${appData.userInfoActiveModel?.getTotalHoursNeedOnline ?? 0}h',
                    style: AppFont.t.s(16).w500.red,
                  ),
                ],
              ),
              BoxConst.s8,
              Text.rich(
                TextSpan(
                    text: 'Từ ngày ',
                    style: AppFont.t.s(12).w500.nuatral50,
                    children: [
                      TextSpan(
                        text: appData.userInfoActiveModel?.getStartDate,
                        style: AppFont.t.s(12).w500.primary,
                      ),
                      TextSpan(
                        text: ' đến hết ngày ',
                        style: AppFont.t.s(12).w500.nuatral50,
                      ),
                      TextSpan(
                        text: appData.userInfoActiveModel?.getEndDate,
                        style: AppFont.t.s(12).w500.primary,
                      ),
                    ]),
              ),
            ],
          ),
        ),
        BoxConst.s12,
        Text.rich(
          TextSpan(text: '* ', style: AppFont.t.s(12).w400.primary, children: [
            TextSpan(
              text:
                  'Bạn sẽ bị khóa tài khoản nếu thời gian hoạt động không đạt.',
              style: AppFont.t.s(12).w500.nuatral90,
            ),
          ]),
        ),
        BoxConst.s12,
        Assets.svgs.amico.svg(width: 400.w)
      ],
    );
  }
}
