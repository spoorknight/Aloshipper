import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/notification_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/list_notification_model/notification_model.dart';
import '../../utils/helpers/logger.dart';

class NotificationViewModel extends BaseViewModel {
  final NotificationRepository notiRepo;

  NotificationViewModel({required this.notiRepo}) : super() {
    getListNotification();
    scrollController.addListener(loadMoreNoti);
  }

  List<NotificationModel> notifications = [];

  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  Future<void> onRefreshNoti() async {
    page = 1;
    isLastPage = false;
    refreshController.refreshCompleted();
    getListNotification();
  }

  Future<void> getListNotification() async {
    setLoading = true;
    try {
      perPage = 20;
      final res = await notiRepo.getListNotification(
          appData.tokenLogin, appData.firebaseToken, page, perPage);
      if (res.status == true) {
        notifications = res.list ?? [];
      }
    } catch (e) {
      Logger.d('GET LIST NOTIFICATION >>>', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreNoti() async {
    try {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          final res = await notiRepo.getListNotification(
              appData.tokenLogin, appData.firebaseToken, page, perPage);
          if (res.status == true) {
            notifications.addAll(res.list ?? []);
            isLastPage = !(res.status ?? false) || (res.list?.isEmpty ?? true);
          } else {
            isLastPage = true;
          }
        }
      }
    } catch (e) {
      Logger.d('LOAD MORE NOTIFICATION >>>', e);
    } finally {
      notifyListeners();
    }
  }
}
