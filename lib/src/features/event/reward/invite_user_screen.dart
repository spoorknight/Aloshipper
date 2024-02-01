import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../configs/config.dart';
import '../../../navigator/app_navigator.dart';
import '../../../navigator/routes.dart';
import '../../../shared/app_bar.dart';
import '../../../shared/my_scaffold.dart';
import '../../../shared/show_toast.dart';
import '../../../utils/app_enum.dart';
import '../event_view_model.dart';
import '../widgets/rules_widget.dart';
import '../widgets/status_stepper/status_stepper.dart';

class InviteUserScreen extends StatelessWidget {
  final String title;

  const InviteUserScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      appBar: MyAppBar(
        title: title,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxConst.s16,
                  renderShareInfo(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.w),
                    decoration: AppTheme.boxDecoration.copyWith(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        renderContent(),
                        renderContainerProcess(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BoxConst.s8,
          const RulesWidget(),
        ],
      ),
    );
  }

  Widget renderContainerProcess() {
    return Consumer<EventViewModel>(builder: (context, viewModel, _) {
      if (viewModel.missionShare?.getMissionType == MissionType.referFriend) {
        return Column(
          children: [
            BoxConst.s12,
            renderProgress(),
            renderBtnHarvest(),
          ],
        );
      }
      return const SizedBox();
    });
  }

  Widget renderShareInfo() {
    return Consumer<EventViewModel>(builder: (context, viewModel, _) {
      if (viewModel.missionShare?.getMissionType == MissionType.referFriend) {
        return Column(
          children: [
            Text(
              'Giới thiệu bạn bè',
              style: AppFont.t.s(14).w700.nuatral90,
            ),
            BoxConst.s8,
            renderShareApp(),
            BoxConst.s8,
          ],
        );
      }
      return const SizedBox();
    });
  }

  Widget renderShareApp() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: const [0.5, 0.9],
          colors: Palette.bgColorShare,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mã giới thiệu',
                      style: AppFont.t.s(14).w500.white,
                    ),
                    BoxConst.s8,
                    Consumer<EventViewModel>(builder: (context, viewModel, _) {
                      return InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(
                                text: viewModel.linkMoiDangKyTaiKhoan),
                          );

                          ShowToast.success("Đã lưu mã giới thiệu");
                        },
                        child: Container(
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Palette.nuatral90,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 6.w,
                            horizontal: 8.w,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  viewModel.codeShare,
                                  style: AppFont.t.s(14).w500.white,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(
                                Icons.copy_outlined,
                                color: Palette.white,
                                size: 24,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                    BoxConst.s8,
                    Consumer<EventViewModel>(builder: (context, viewModel, _) {
                      return InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(
                                text: viewModel.linkMoiDangKyTaiKhoan),
                          );

                          ShareResult shareResult = await Share.shareWithResult(
                              viewModel.linkMoiDangKyTaiKhoan);

                          if (shareResult.status ==
                              ShareResultStatus.success) {}
                        },
                        child: Container(
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Palette.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 6.w,
                            horizontal: 24.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.share,
                                color: Palette.nuatral90,
                                size: 24,
                              ),
                              BoxConst.s8,
                              Text(
                                'Chia sẻ',
                                style: AppFont.t.s(13).w700.nuatral90,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              BoxConst.s12,
              Assets.svgs.walletShare.svg(width: 84.w),
            ],
          ),
          BoxConst.s8,
          Consumer<EventViewModel>(builder: (context, viewModel, _) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đã thu hoạch',
                        style: AppFont.t.s(16).w500.white,
                      ),
                      Text(
                        (viewModel.missionShare?.getTotalHarvest.toString() ??
                                '0')
                            .toPoint,
                        style: AppFont.t.s(13).w400.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ươm mầm',
                        style: AppFont.t.s(16).w500.white,
                      ),
                      Text(
                        (viewModel.missionShare?.tempPoints ?? '0').toPoint,
                        style: AppFont.t.s(13).w400.white,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget renderContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Box.s8,
        Consumer<EventViewModel>(builder: (context, viewModel, _) {
          return Text.rich(
            TextSpan(
              text: 'Cách Nhận: ',
              style: AppFont.t.s(13).w400.nuatral90,
              children: [
                TextSpan(
                  text: (viewModel.missionShare?.childMissions?.totalPoint
                              .toString() ??
                          '0')
                      .toPoint,
                  style: AppFont.t.s(13).w700.error,
                ),
              ],
            ),
          );
        }),
        BoxConst.s16,
        Consumer<EventViewModel>(builder: (context, viewModel, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: '1. ',
                  style: AppFont.t.s(13).w400.nuatral90,
                  children: [
                    TextSpan(
                      text: viewModel
                              .missionShare?.childMissions?.registers?.title ??
                          '',
                    ),
                  ],
                ),
              ),
              BoxConst.s4,
              Text.rich(
                TextSpan(
                  text: 'Nhận được: ',
                  style: AppFont.t.s(10).w400.nuatral90,
                  children: [
                    TextSpan(
                      text: (viewModel.missionShare?.childMissions?.registers
                                  ?.points
                                  .toString() ??
                              '0')
                          .toPoint,
                      style: AppFont.t.s(10).w400.error,
                    ),
                  ],
                ),
              )
            ],
          );
        }),
        BoxConst.s16,
        Consumer<EventViewModel>(builder: (context, viewModel, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: '2. ',
                  style: AppFont.t.s(13).w400.nuatral90,
                  children: [
                    TextSpan(
                      text: viewModel.missionShare?.childMissions
                              ?.completedOrders?.title ??
                          '',
                    ),
                  ],
                ),
              ),
              BoxConst.s4,
              Text.rich(
                TextSpan(
                  text: 'Nhận được: ',
                  style: AppFont.t.s(10).w400.nuatral90,
                  children: [
                    TextSpan(
                      text: (viewModel.missionShare?.childMissions
                                  ?.completedOrders?.points
                                  .toString() ??
                              '0')
                          .toPoint,
                      style: AppFont.t.s(10).w400.error,
                    ),
                  ],
                ),
              )
            ],
          );
        }),
        BoxConst.s16,
        Consumer<EventViewModel>(builder: (context, viewModel, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: '3. ',
                  style: AppFont.t.s(13).w400.nuatral90,
                  children: [
                    TextSpan(
                      text: viewModel
                              .missionShare?.childMissions?.adViews?.title ??
                          '',
                    ),
                  ],
                ),
              ),
              BoxConst.s4,
              Text.rich(
                TextSpan(
                  text: 'Nhận được: ',
                  style: AppFont.t.s(10).w400.nuatral90,
                  children: [
                    TextSpan(
                      text: (viewModel
                                  .missionShare?.childMissions?.adViews?.points
                                  .toString() ??
                              '0')
                          .toPoint,
                      style: AppFont.t.s(10).w400.error,
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ],
    );
  }

  Widget renderItem(bool isDone) {
    if (isDone) {
      return Assets.svgs.checkProgres.svg(width: 20.w, height: 20.w);
    } else {
      return CircleAvatar(
        radius: 14.r,
        backgroundColor: Palette.nuatral30,
        child: Icon(
          Icons.lock,
          color: Palette.white,
          size: 16.w,
        ),
      );
    }
  }

  Widget renderProgress() {
    return SizedBox(
      width: double.infinity,
      child: Consumer<EventViewModel>(builder: (context, viewModel, _) {
        int currentIndex = -1;

        final statuses = List.generate(4, (index) {
          if (index == 0) {
            currentIndex += ((viewModel.missionShare?.childMissions?.registers
                            ?.isCompleted ??
                        false) &&
                    currentIndex == -1)
                ? 1
                : 0;
            return renderItem(
                viewModel.missionShare?.childMissions?.registers?.isCompleted ??
                    false);
          }
          if (index == 1) {
            currentIndex += ((viewModel.missionShare?.childMissions
                            ?.completedOrders?.isCompleted ??
                        false) &&
                    currentIndex == 0)
                ? 1
                : 0;

            return renderItem(viewModel.missionShare?.childMissions
                    ?.completedOrders?.isCompleted ??
                false);
          }
          if (index == 2) {
            currentIndex +=
                ((viewModel.missionShare?.childMissions?.adViews?.isCompleted ??
                            false) &&
                        currentIndex == 1)
                    ? 1
                    : 0;

            return renderItem(
                viewModel.missionShare?.childMissions?.adViews?.isCompleted ??
                    false);
          }
          return const SizedBox.shrink();
        });

        if (viewModel.missionShare?.childMissions?.isCompleteAll == true) {
          currentIndex = statuses.length;
        }

        return Column(
          children: [
            StatusStepper(
              connectorCurve: Curves.easeIn,
              itemCurve: Curves.easeOut,
              disabledColor: Palette.nuatral30,
              animationDuration: const Duration(milliseconds: 500),
              lastActiveIndex: -1,
              currentIndex: currentIndex,
              connectorThickness: 6,
              children: statuses,
            ),
            BoxConst.s8,
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.progressOfFriendScreen,
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Theo dõi tiến độ',
                      style: AppFont.t.s(10).w500.linkBlue,
                    ),
                    BoxConst.s4,
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Palette.linkBlue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget renderBtnHarvest() {
    return Consumer<EventViewModel>(builder: (context, viewModel, _) {
      if ((viewModel.missionShare?.getTotalHarvest ?? 0) <= 0) {
        return InkWell(
          onTap: () => viewModel.addGiftForReferFriendMission(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.5.w),
            width: double.infinity,
            decoration: AppTheme.boxDecoration.copyWith(
              borderRadius: BorderRadius.circular(10.r),
              gradient: LinearGradient(
                colors: Palette.btnHarvest,
              ),
            ),
            child: Center(
              child: Text(
                'Thu hoạch',
                style: AppFont.t.s(16).w700.white,
              ),
            ),
          ),
        );
      }
      return const SizedBox();
    });
  }
}
