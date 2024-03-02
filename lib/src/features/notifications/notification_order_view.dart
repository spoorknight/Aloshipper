import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/features/notifications/widget/item_notification.dart';
import 'package:app_shipper/src/features/notifications/notification_view_model.dart';
import 'package:app_shipper/src/shared/empty.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationOrderView extends StatelessWidget {
  NotificationViewModel viewModel;
  NotificationOrderView({super.key,required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: viewModel.refreshController,
      onLoading: () => viewModel.loadMoreNoti(),
      enablePullUp: viewModel.isLastPage ? false : true,
      onRefresh: () => viewModel.onRefreshNoti(),
      child: viewModel.notifications.isEmpty
          ? const Empty()
          : ListView.separated(
        controller: viewModel.scrollController,
        padding: EdgeInsets.symmetric(vertical: 16.w),
        itemCount: viewModel.notifications.length,
        separatorBuilder: (_, i) => SizedBox(
          height: 8.w,
        ),
        itemBuilder: (_, i) =>
            ItemNoti(noti: viewModel.notifications[i]),
      ),
    );
  }
}
