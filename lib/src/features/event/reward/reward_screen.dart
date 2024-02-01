import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/config.dart';
import '../../../di/injection/injection.dart';
import '../../../models/event/mission_model.dart';
import '../../../navigator/routes.dart';
import '../../../shared/button.dart';
import '../../../shared/dialog.dart';
import '../../../shared/empty.dart';
import '../../../shared/loading.dart';
import '../../../shared/my_scaffold.dart';
import '../../../utils/app_enum.dart';
import '../../../widgets/base_button_widget.dart';
import '../event_view_model.dart';
import '../widgets/custom_event_button.dart';
import '../widgets/rules_widget.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>
    with AutomaticKeepAliveClientMixin<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      body: Column(
        children: [
          Expanded(
            child: Consumer<EventViewModel>(builder: (context, viewModel, _) {
              return SmartRefresher(
                // scrollController: viewModel.scrollCtl,
                controller: viewModel.refreshRewardCtl,
                enablePullUp: false,
                onRefresh: viewModel.initData,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BoxConst.s8,
                      renderPoint(context),
                      BoxConst.s8,
                      renderMissions(context),
                    ],
                  ),
                ),
              );
            }),
          ),
          BoxConst.s8,
          const RulesWidget(),
        ],
      ),
    );
  }

  Widget renderPoint(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Builder(builder: (context) {
        return Consumer<EventViewModel>(builder: (context, viewModel, _) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    'Điểm của bạn',
                    style: AppFont.t.s(12).w400.nuatral90,
                  ),
                  BoxConst.s4,
                  Assets.svgs.coin.svg(width: 14.w, height: 14.w),
                ],
              ),
              BoxConst.s8,
              if (viewModel.customerPointInfoLoading) ...[
                const Loading(),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: (viewModel.customerPointInfoModel
                                    ?.userCurrentPoints ??
                                0)
                            .toString()
                            .toPoint,
                        style: AppFont.t.s(14).w700.nuatral90,
                      ),
                    ),
                    MyButton.rounded(
                      title: 'Đổi thưởng',
                      width: 77.w,
                      height: 28.h,
                      borderRadius: 20.r,
                      titleStyle: AppFont.t.s(12).w500.white,
                      action: () {
                        Navigator.of(context).pushNamed(
                          Routes.redeemRewardsScreen,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ],
          );
        });
      }),
    );
  }

  Widget renderMissions(BuildContext context) {
    return Container(
      width: context.device.width,
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: const [0.1, 0.5, 0.7, 0.9],
          colors: Palette.bgColorEvent,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<EventViewModel>(builder: (context, viewModel, _) {
                return Expanded(
                  child: Text(
                    viewModel.missionTitle,
                    style: AppFont.t.s(16).w500.white,
                  ),
                );
              }),
              BoxConst.s12,
              Assets.svgs.coinTask.svg(width: 150.w),
            ],
          ),
          BoxConst.s12,
          Container(
            padding: EdgeInsets.symmetric(vertical: 13.w, horizontal: 13.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Consumer<EventViewModel>(builder: (context, viewModel, _) {
              if (viewModel.customerMissionLoading) {
                return const Loading();
              }
              if (viewModel.listMissions.isEmpty) {
                return const Empty(
                  text: 'Hiện tại chưa có nhiệm vụ nào',
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.listMissions.length,
                itemBuilder: (context, index) {
                  MissionModel item = viewModel.listMissions[index];

                  bool isMissionDone = item.checkDisableButton;
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item.name ?? '',
                                  style: AppFont.t.s(12).w700.nuatral90,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (item.id != null &&
                                    (item.description ?? '').isNotEmpty) ...[
                                  BaseButtonWidget(
                                    onTap: () => showDialogDescription(
                                        item.description!),
                                    child: Icon(
                                      Icons.help_outline,
                                      size: 16.sp,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                            if (item.getBeginAt.isNotEmpty &&
                                item.getEndAt.isNotEmpty) ...[
                              BoxConst.s2,
                              Text.rich(
                                TextSpan(
                                  text: 'Thời gian từ ngày ',
                                  style: AppFont.t.s(10).w400.nuatral50,
                                  children: [
                                    TextSpan(
                                      text: item.getBeginAt,
                                      style: AppFont.t.s(10).w400.nuatral50,
                                    ),
                                    TextSpan(
                                      text: ' đến ngày ',
                                      style: AppFont.t.s(10).w400.nuatral50,
                                    ),
                                    TextSpan(
                                      text: item.getEndAt,
                                      style: AppFont.t.s(10).w400.nuatral50,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            BoxConst.s2,
                            Row(
                              children: [
                                if (item.getPointValue > 0) ...[
                                  Row(
                                    children: [
                                      Text(
                                        '+${(item.getPointValue).toString().formatNumber}',
                                        style: AppFont.t.s(12).w400.error,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      BoxConst.s4,
                                      Assets.svgs.coin
                                          .svg(width: 11.w, height: 11.w),
                                    ],
                                  ),
                                ],
                                if (item.getPointValue > 0 &&
                                    item.getDayValue > 0 &&
                                    appData.checkIsShipperOrStore)
                                  Text(
                                    ' hoặc ',
                                    style: AppFont.t.s(12).w400.nuatral90,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                if (item.getDayValue > 0 &&
                                    appData.checkIsShipperOrStore) ...[
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          '+${(item.getDayValue).toString().formatNumber} ',
                                      style: AppFont.t.s(12).w400.error,
                                      children: [
                                        TextSpan(
                                          text: 'ngày sử dụng',
                                          style: AppFont.t.s(12).w400.nuatral90,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      BoxConst.s4,
                      Column(
                        children: [
                          CustomEventButton(
                            txtButton:
                                isMissionDone ? 'Hoàn thành' : 'Thực hiện',
                            isDisable: isMissionDone,
                            leftWidget:
                                item.getMissionType == MissionType.adViews &&
                                        !item.checkDisableButton
                                    ? Assets.svgs.theater
                                        .svg(width: 16.w, height: 16.w)
                                    : null,
                            onTap: () {
                              checkAction(item, viewModel);
                            },
                          ),
                          if (item.checkNumDayNeedToDone > 0 &&
                              !item.checkIsUnlimitedTimes) ...[
                            BoxConst.s4,
                            Text(
                              'Còn ${item.checkNumDayNeedToDone} lần',
                              style: AppFont.t.s(10).w400.nuatral90,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.w),
                    child: const Divider(color: Palette.nuatral30),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> checkAction(MissionModel item, EventViewModel viewModel) async {
    if (item.getMissionType == MissionType.adViews) {
      try {
        EasyLoading.show();
        final res = await viewModel.checkValidAdViews();
        if (res) {
          await viewModel.loadRewardedAd();
        } else {
          EasyLoading.dismiss();
        }
      } catch (e) {
        EasyLoading.dismiss();
      }
    } else if (item.getMissionType == MissionType.checkIn) {
      viewModel.createCheckIn(item.id ?? '1');
    } else if (item.getMissionType == MissionType.share) {
      Navigator.of(context).pushNamed(Routes.listStoresScreen);
    } else {
      viewModel.missionShare = item;
      Navigator.of(context).pushNamed(Routes.inviteUserScreen, arguments: {
        'title': item.getMissionType == MissionType.referFriend
            ? "Chia sẻ bạn bè"
            : "Chi tiết",
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
