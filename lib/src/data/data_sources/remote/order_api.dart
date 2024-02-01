import 'package:app_shipper/src/models/cancel_order_model.dart';
import 'package:app_shipper/src/models/list_order_model/list_order_model.dart';
import 'package:app_shipper/src/models/shared_models/base_model.dart';

import '../../../models/detail_order_model/detail_order_model.dart';

import '../../../network/api_path.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'order_api.g.dart';

@RestApi()
abstract class OrderApi {
  factory OrderApi(Dio dio, {String baseUrl}) = _OrderApi;

  @POST(ApiPath.getDetailOrderShipperById)
  @MultiPart()
  Future<DetailOrderModel> getDetailOrderShipperById(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'order_id') int order_id,
  );

  @GET(ApiPath.getCancelReasons)
  Future<ResponseCancelOrderModel> getCancelReasons();

  @POST(ApiPath.updateStatusOrderByShipper)
  @MultiPart()
  Future<BaseModel> updateStatusOrderByShipper(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'order_id') int order_id,
    @Part(name: 'order_status') String order_status,
  );

  @POST(ApiPath.shopOnlineActive)
  @MultiPart()
  Future<BaseModel> setOnlineActive(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'active') int active,
  );

  @POST(ApiPath.getListCompletedOrdersShipper)
  @MultiPart()
  Future<ListOrderModel> getListCompletedOrdersShipper(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'date') String? date,
    @Part(name: 'date_to') String? date_to,
    @Part(name: 'page') int page,
    @Part(name: 'per_page') int per_page,
  );

  @POST(ApiPath.ShipperHuyDonHangNew)
  @MultiPart()
  Future<BaseModel> cancelOrder(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'order_id') int order_id,
    @Part(name: 'lydohuy') String reason,
  );
}
