import '../../../models/list_notification_model/list_notification_model.dart';

import '../../../network/api_path.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'noti_api.g.dart';

@RestApi()
abstract class NotiApi {
  factory NotiApi(Dio dio, {String baseUrl}) = _NotiApi;

  @POST(ApiPath.getListThongBaoV2)
  @MultiPart()
  Future<ListNotificationModel> getListNotification(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'page') int page,
    @Part(name: 'per_page') int per_page,
  );
}
