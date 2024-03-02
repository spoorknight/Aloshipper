import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/features/notifications/widget/item_news.dart';
import 'package:app_shipper/src/features/notifications/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../shared/empty.dart';

class NotificationNewsView extends StatelessWidget {
  NotificationViewModel viewModel;
  NotificationNewsView({super.key,required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: viewModel.refreshControllerNews,
      onLoading: () => viewModel.loadMoreNotiNew(),
      enablePullUp: viewModel.isLastPageNew ? false : true,
      onRefresh: () => viewModel.onRefreshNotiNew(),
      child: viewModel.notificationNews.isEmpty
          ? const Empty()
          : ListView.separated(
        controller: viewModel.scrollControllerNews,
        padding: EdgeInsets.symmetric(vertical: 16.w),
        itemCount: viewModel.notificationNews.length,
        separatorBuilder: (_, i) => SizedBox(
          height: 15.w,
        ),
        itemBuilder: (_, i) => InkWell(
            onTap: () => viewModel.readNew(viewModel.notificationNews[i]),
            child: ItemNews(model:viewModel.notificationNews[i])),
      ),
    );

  }
}
