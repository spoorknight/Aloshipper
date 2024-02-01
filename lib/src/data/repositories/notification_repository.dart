import '../../models/list_notification_model/list_notification_model.dart';

abstract class NotificationRepository {
  Future<ListNotificationModel> getListNotification(
      String tokenlogin, String device_token, int page, int per_page);
}
