import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../navigator/routes.dart';
import '../../../shared/loading.dart';
import '../../../widgets/coupon_uikit/coupon_uikit.dart';
import '../event_view_model.dart';

class CustomerPointWidget extends StatelessWidget {
  const CustomerPointWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CouponCard(
      height: 150.sp,
      curvePosition: 100.sp,
      curveRadius: 16.r,
      borderRadius: 8.r,
      normalBorder: true,
      decoration: const BoxDecoration(
        color: Palette.black181818,
      ),
      firstChild: Container(
        padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<EventViewModel>(builder: (context, viewModel, _) {
              if (viewModel.customerPointInfoLoading) {
                return const Loading();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Số điểm của bạn',
                    style: AppFont.t.s(12).w700.white,
                  ),
                  BoxConst.s4,
                  Text(
                    '${'${viewModel.customerPointInfoModel?.userCurrentPoints ?? 0}'.formatNumber} điểm',
                    style: AppFont.t.s(18).w700.white,
                  ),
                ],
              );
            }),
            Assets.svgs.coin.svg(width: 64.w),
          ],
        ),
      ),
      secondChild: Consumer<EventViewModel>(builder: (context, viewModel, _) {
        if (viewModel.customerPointInfoLoading) {
          return const Loading();
        }
        return CustomPaint(
          painter: DrawDottedHorizontalLine(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 10.w),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.historiesRedeemRewardScreen,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Lịch sử giao dịch của bạn',
                      style: AppFont.t.s(12).w300.white,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Palette.white,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
