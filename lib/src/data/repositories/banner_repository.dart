import '../../models/banner_ads_model.dart';

abstract class BannerRepository {
  Future<BannerAdsResponse> getBannerAdsAdmobKeys();
}
