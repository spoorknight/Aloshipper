part of '../reward/histories_redeem_rewards_screen.dart';

class RedeemedScreen extends StatelessWidget {
  const RedeemedScreen({super.key});

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
            controller: viewModel.refreshCtlRedeem,
            onRefresh: viewModel.onRefreshPointsExchangeHistories,
            enablePullDown: true,
            child: viewModel.historiesExchangePoint.isEmpty
                ? const Empty(text: 'Bạn vẫn chưa đổi điểm!')
                : ListView.separated(
                    padding: AppTheme.mainPadding.copyWith(top: 16, bottom: 16),
                    itemBuilder: (context, index) {
                      ExchangePointModel item =
                          viewModel.historiesExchangePoint[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Đổi ${(item.totalPoints ?? 0).toString().toPoint}',
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
                            item.getValueShowing,
                            style: AppFont.t.s(12).w500.black,
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.w),
                      child: const Divider(color: Palette.nuatral30),
                    ),
                    itemCount: viewModel.historiesExchangePoint.length,
                  ),
          );
        }),
      ),
    );
  }

  Widget renderWatchMore() {
    return Consumer<EventViewModel>(builder: (context, viewModel, _) {
      if (viewModel.historiesExchangePoint.isEmpty ||
          !viewModel.historiesMissionCanLoadMore) {
        return const SizedBox();
      }
      return InkWell(
        onTap: () {
          viewModel.onLoadMorePointsExchangeHistories();
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
