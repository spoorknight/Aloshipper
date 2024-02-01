part of '../reward/histories_redeem_rewards_screen.dart';

class MissionTab extends StatelessWidget {
  const MissionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        renderContent(),
        renderWatchMore(),
      ],
    );
  }

  Widget renderContent() {
    return Expanded(
      child: Container(
        color: Palette.white,
        child: Consumer<EventViewModel>(builder: (context, viewModel, _) {
          return SmartRefresher(
            controller: viewModel.refreshCtlHistoriesMission,
            onRefresh: viewModel.onRefreshMissionHistories,
            enablePullDown: true,
            child: viewModel.historiesMission.isEmpty
                ? const Empty(text: 'Bạn chưa thực hiện nhiệm vụ!')
                : ListView.separated(
                    padding: AppTheme.mainPadding.copyWith(top: 16, bottom: 16),
                    itemBuilder: (context, index) {
                      HistoryMissionModel item =
                          viewModel.historiesMission[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.getName,
                                  style: AppFont.t.s(12).w400.black,
                                ),
                                BoxConst.s4,
                                Row(
                                  children: [
                                    Text(
                                      item.getDate,
                                      style: AppFont.t.s(12).w300.black,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      child: Icon(
                                        Icons.circle,
                                        size: 6,
                                        color: Palette.nuatral50,
                                      ),
                                    ),
                                    Text(
                                      item.getTime,
                                      style: AppFont.t.s(12).w300.black,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text(
                            '+ ${item.getValue} ${item.getUnit}',
                            style: AppFont.t.s(12).w500.black,
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.w),
                      child: const Divider(color: Palette.nuatral30),
                    ),
                    itemCount: viewModel.historiesMission.length,
                  ),
          );
        }),
      ),
    );
  }

  Widget renderWatchMore() {
    return Consumer<EventViewModel>(builder: (context, viewModel, _) {
      if (viewModel.historiesMission.isEmpty ||
          !viewModel.historiesExchangePointCanLoadMore) {
        return const SizedBox();
      }
      return InkWell(
        onTap: () {
          viewModel.onLoadMoreMissionHistories();
        },
        child: Container(
          color: Palette.newLightGrey,
          margin: EdgeInsets.only(top: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Xem thêm',
                style: AppFont.t.s(10).w500.linkBlue,
              ),
              BoxConst.s4,
              const Icon(
                Icons.keyboard_arrow_down,
                color: Palette.linkBlue,
                size: 18,
              ),
            ],
          ),
        ),
      );
    });
  }
}
