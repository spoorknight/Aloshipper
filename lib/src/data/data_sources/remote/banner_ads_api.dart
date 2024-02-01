import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../models/banner_ads_model.dart';
import '../../../network/api_path.dart';

part 'banner_ads_api.g.dart';

@RestApi()
abstract class BannerAdsApi {
  factory BannerAdsApi(Dio dio, {String baseUrl}) = _BannerAdsApi;

  @POST(ApiPath.getBannerAdsAdmobKeys)
  @MultiPart()
  Future<BannerAdsResponse> getBannerAdsAdmobKeys();
}