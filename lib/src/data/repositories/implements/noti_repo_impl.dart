import 'package:app_shipper/src/models/list_notification_model/count_unread_new_model.dart';
import 'package:app_shipper/src/models/list_notification_model/list_new_model.dart';

import '../../data_sources/remote/noti_api.dart';
import '../../../models/list_notification_model/list_notification_model.dart';

import '../notification_repository.dart';

class NotiRepoImpl implements NotificationRepository {
  final NotiApi notiApi;
  const NotiRepoImpl({required this.notiApi});

  @override
  Future<ListNotificationModel> getListNotification(
      String tokenlogin, String device_token, int page, int per_page) {
    return notiApi.getListNotification(
        tokenlogin, device_token, page, per_page);
  }

  @override
  Future<ListNewModel> getListNew(
      String tokenlogin, int page, int per_page, String read_type) {
    return notiApi.getListNew(
        tokenlogin,page, per_page,read_type);
  }

  @override
  Future<CountUnreadNewModel> countUnReadNew(
      String tokenlogin) {
    return notiApi.countUnReadNew(
        tokenlogin);
  }

  @override
  Future<NotificationNewModel> getDetailNoti(
      String tokenlogin,String id) {
    return notiApi.getDetailNoti(
        tokenlogin,id);
  }

  @override
  Future readNew(
      String tokenlogin,String noti_id) {
    return notiApi.readNew(
        tokenlogin,noti_id);
  }
}
