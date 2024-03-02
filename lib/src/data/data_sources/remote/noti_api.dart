import 'package:app_shipper/src/models/list_notification_model/count_unread_new_model.dart';
import 'package:app_shipper/src/models/list_notification_model/list_new_model.dart';

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

  @POST(ApiPath.getNotiNews)
  @MultiPart()
  Future<ListNewModel> getListNew(
    @Part(name: 'token') String tokenlogin,
    @Part(name: 'page') int page,
    @Part(name: 'per_page') int per_page,
    @Part(name: 'read_type') String read_type,
  );

  @POST(ApiPath.countUnReadNotiNews)
  @MultiPart()
  Future<CountUnreadNewModel> countUnReadNew(
      @Part(name: 'token') String tokenlogin,
      );

  @POST(ApiPath.readNotiNews)
  @MultiPart()
  Future readNew(
      @Part(name: 'token') String tokenlogin,
      @Part(name: 'noti_id') String noti_id,
      );
}
