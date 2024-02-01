part of '../extend_screen.dart';

class MissionWidget extends StatelessWidget {
  const MissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double heightWidget = 80.sp;
    return Column(
      children: [
        Consumer<EventViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.customerMissionLoading) {
              return const Loading();
            }

            if (viewModel.listMissions.isNotEmpty) {
              MissionModel? item = viewModel.listMissions.firstWhereOrNull(
                (element) => element.getMissionType == MissionType.adViews,
              );
              if (item != null) {
                bool isMissionDone = item.checkDisableButton;
                return StatefulBuilder(builder: (context, st) {
                  return MeasureSize(
                    onChange: (size) {
                      st(() {
                        // heightWidget = size.height;
                      });
                    },
                    child: Container(
                      decoration: AppTheme.boxDecoration.copyWith(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.sp, horizontal: 10.sp),
                      margin: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name ?? '',
                                  style: AppFont.t.s(12).w700.nuatral90,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                BoxConst.s2,
                                Text(
                                  item.getShortDescription,
                                  style: AppFont.t.s(13).w400.nuatral90,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: heightWidget,
                            child: AdvancedLine(
                              direction: Axis.vertical,
                              line: DashedLine(dashSize: 2.sp, gapSize: 5.sp),
                              paintDef: Paint()
                                ..strokeWidth = 1.sp
                                ..strokeCap = StrokeCap.round
                                ..color = Palette.nuatral30,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BaseButtonWidget(
                                  onTap: () async {
                                    try {
                                      EasyLoading.show();
                                      final res =
                                          await viewModel.checkValidAdViews();
                                      if (res) {
                                        await viewModel.loadRewardedAd();
                                      } else {
                                        EasyLoading.dismiss();
                                      }
                                    } catch (e) {
                                      EasyLoading.dismiss();
                                    }
                                  },
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.sp, horizontal: 12.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: Palette.linkBlue,
                                  ),
                                  icon: Assets.svgs.theater
                                      .svg(width: 16.sp, height: 16.sp),
                                  child: Text(
                                    isMissionDone ? 'Hoàn thành' : 'Thực hiện',
                                    style: AppFont.t.s(10).w500.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
              }
            }
            return const Empty(
              text: 'Hiện tại chưa có nhiệm vụ nào',
            );
          },
        ),
        BoxConst.s12,
      ],
    );
  }
}
