import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/palette.dart';
import '../../shared/app_bar.dart';
import '../../shared/empty.dart';
import '../../shared/loading.dart';
import '../../shared/my_scaffold.dart';
import 'item_notification.dart';
import 'notification_view_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificationViewModel>();
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      padding: EdgeInsets.zero,
      appBar:
          const MyAppBar(title: 'Thông báo', backgroundColor: Palette.white),
      body: viewModel.isLoading
          ? const Loading()
          : SmartRefresher(
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
            ),
    );
  }
}
