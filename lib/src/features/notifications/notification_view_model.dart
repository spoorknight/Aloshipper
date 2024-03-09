import 'package:app_shipper/src/models/list_notification_model/list_new_model.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/navigator/routes.dart';
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
    getListNotificationNews();
    getCountUnReadNew();
    scrollController.addListener(loadMoreNoti);
    scrollControllerNews.addListener(loadMoreNotiNew);
  }

  List<NotificationModel> notifications = [];
  List<NotificationNewModel> notificationNews = [];

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
          appData.tokenLogin,appData.firebaseToken, page, perPage);
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





  final RefreshController refreshControllerNews = RefreshController();
  final ScrollController scrollControllerNews = ScrollController();
  int pageNew = 1;
  int perPageNew = 10;
  bool isLastPageNew = false;
  int countUnReadNew = 0;
  String type = 'all';

  Future<void> getCountUnReadNew() async {
    final res = await notiRepo.countUnReadNew(appData.tokenLogin);
    countUnReadNew = res.data?.unreadCount ?? 0;
    notifyListeners();
  }

  Future<void> filterListNews(String value) async {
    type = value;
    AppNavigator.pop();
    await getListNotificationNews();
  }

  Future<NotificationNewModel> getDetail(String id) async {
    final model = await notiRepo.getDetailNoti(appData.tokenLogin, id);
    await readNew(model);
    return model;
  }

  Future<void> readNew(NotificationNewModel model) async {
    model.isRead = true;
    countUnReadNew -= 1;
    notifyListeners();
   await AppNavigator.push(Routes.detailNewScreen,arguments: model);
   await notiRepo.readNew(appData.tokenLogin, model.id ?? "");
   await getCountUnReadNew();

  }

  Future<void> onRefreshNotiNew() async {
    pageNew = 1;
    isLastPageNew = false;
    refreshControllerNews.refreshCompleted();
    getListNotification();
  }

  Future<void> getListNotificationNews() async {
    try {
      perPageNew = 20;
      final res = await notiRepo.getListNew(
          appData.tokenLogin, pageNew, perPageNew,type);
      if (res.status == true) {
        notificationNews = res.data ?? [];
      }
    } catch (e) {
      Logger.d('GET LIST NOTIFICATION NEWS >>>', e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadMoreNotiNew() async {
    try {
      if (scrollControllerNews.position.pixels ==
          scrollControllerNews.position.maxScrollExtent) {
        if (!isLastPageNew) {
          pageNew++;
          final res = await notiRepo.getListNew(
              appData.tokenLogin,pageNew, perPageNew,type);
          if (res.status == true) {
            notificationNews.addAll(res.data ?? []);
            isLastPageNew = !(res.status ?? false) || (res.data?.isEmpty ?? true);
          } else {
            isLastPageNew = true;
          }
        }
      }
    } catch (e) {
      Logger.d('LOAD MORE NOTIFICATION NEW >>>', e);
    } finally {
      notifyListeners();
    }
  }



}
