import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/config.dart';
import '../../../models/event/exchange_point_model.dart';
import '../../../models/event/history_mission_model.dart';
import '../../../navigator/app_navigator.dart';
import '../../../shared/app_bar.dart';
import '../../../shared/empty.dart';
import '../../../shared/my_scaffold.dart';
import '../event_view_model.dart';
import '../widgets/rules_widget.dart';

part '../widgets/mission_tab.dart';

part '../widgets/redeem_tab.dart';

class HistoriesRedeemRewardScreen extends StatelessWidget {
  const HistoriesRedeemRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      bgColor: Palette.newLightGrey,
      safeAreaBottom: false,
      appBar: MyAppBar(
        title: 'Lịch sử điểm',
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: Column(
        children: [
          renderUserPoint(),
          BoxConst.s8,
          renderHistoryPoint(),
          BoxConst.s12,
          const RulesWidget(),
          BoxConst.s20,
        ],
      ),
    );
  }

  Widget renderUserPoint() {
    return Container(
      color: Palette.white,
      padding: AppTheme.mainPadding.copyWith(top: 10.w, bottom: 10.w),
      child: Row(
        children: [
          Consumer<EventViewModel>(builder: (context, viewModel, _) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Số điểm',
                    style: AppFont.t.s(13).w300.black,
                  ),
                  BoxConst.s4,
                  Text(
                    '${viewModel.customerPointInfoModel?.userCurrentPoints ?? 0}'
                        .formatNumber,
                    style: AppFont.t.s(16).w400.black,
                  ),
                ],
              ),
            );
          }),
          Container(
            height: 40.w,
            width: 1,
            color: Palette.border,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          Consumer<EventViewModel>(builder: (context, viewModel, _) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tổng điểm đã đổi',
                    style: AppFont.t.s(13).w300.black,
                  ),
                  BoxConst.s4,
                  Text(
                    '${double.tryParse(viewModel.customerPointInfoModel?.userConvertedPoints ?? '0') ?? 0}'
                        .formatNumber,
                    style: AppFont.t.s(16).w400.black,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget renderHistoryPoint() {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            renderTabBar(),
            const SizedBox(
              height: 2,
            ),
            renderBody(),
          ],
        ),
      ),
    );
  }

  Widget renderTabBar() {
    return Container(
      color: Palette.white,
      child: TabBar(
        indicatorColor: Palette.nuatral90,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 12.w),
        labelStyle: AppFont.t.s(13).w500,
        unselectedLabelStyle: AppFont.t.s(13).w500,
        labelColor: Palette.nuatral90,
        unselectedLabelColor: Palette.nuatral90,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        tabs: const [
          Tab(
            child: Text(
              'Nhiệm vụ',
            ),
          ),
          Tab(
            child: Text(
              'Đã đổi',
            ),
          ),
        ],
      ),
    );
  }

  Widget renderBody() {
    return Expanded(
      child: TabBarView(
        children: [
          Consumer<EventViewModel>(builder: (context, viewModel, _) {
            return ChangeNotifierProvider.value(
              value: viewModel,
              child: const MissionTab(),
            );
          }),
          Consumer<EventViewModel>(builder: (context, viewModel, _) {
            return ChangeNotifierProvider.value(
              value: viewModel,
              child: const RedeemedScreen(),
            );
          }),
        ],
      ),
    );
  }
}
