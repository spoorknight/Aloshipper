import 'package:app_shipper/src/models/list_notification_model/count_unread_new_model.dart';
import 'package:app_shipper/src/models/list_notification_model/list_new_model.dart';

import '../../models/list_notification_model/list_notification_model.dart';

abstract class NotificationRepository {
  Future<ListNotificationModel> getListNotification(
      String tokenlogin, String device_token, int page, int per_page);

  Future<ListNewModel> getListNew(
      String tokenlogin, int page, int per_page, String read_type);

  Future<CountUnreadNewModel> countUnReadNew(
      String tokenlogin);

  Future<NotificationNewModel> getDetailNoti(
      String tokenlogin,String id);

  Future readNew(
      String tokenlogin,String noti_id);


}
