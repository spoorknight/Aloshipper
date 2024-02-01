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
}
