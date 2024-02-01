import '../../../models/collaborate_info_model/collaborate_info_model.dart';
import '../../../models/list_bought_customer_model/list_hoa_hong_model.dart';
import '../../../models/list_discount_product_model/list_discount_product_model.dart';

import '../../../models/list_store_recommend_model/list_store_recommend_model.dart';
import '../../../network/api_path.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'collab_api.g.dart';

@RestApi()
abstract class CollabApi {
  factory CollabApi(Dio dio, {String baseUrl}) = _CollabApi;

  @POST(ApiPath.getInfoTaiKhoanHopTac)
  @MultiPart()
  Future<CollaborateInfoModel> getCollbabInfo(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
  );

  @POST(ApiPath.getListHoaHongSanPham)
  @MultiPart()
  Future<ListBoughtCustomerModel> getBoughtCustomer(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'page') int page,
    @Part(name: 'per_page') int per_page,
    @Part(name: 'date') String? date,
    @Part(name: 'status') String? status,
  );

  @POST(ApiPath.getListSanPhamDangChiecKhau)
  @MultiPart()
  Future<ListDiscountProductModel> getListDiscountProduct(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'page') int page,
    @Part(name: 'per_page') int per_page,
  );

  @POST(ApiPath.getListHoaHongMoShopApi)
  @MultiPart()
  Future<ListStoreRecommendModel> getListStoreRecommend(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'page') int page,
    @Part(name: 'per_page') int per_page,
    @Part(name: 'date') String? date,
    @Part(name: 'status') String? status,
  );
}
