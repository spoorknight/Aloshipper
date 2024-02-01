import 'package:app_shipper/src/data/repositories/banner_repository.dart';
import 'package:app_shipper/src/models/banner_ads_model.dart';

import '../../data_sources/remote/banner_ads_api.dart';

class BannerRepoImpl implements BannerRepository {
  final BannerAdsApi bannerAdsApi;

  const BannerRepoImpl({required this.bannerAdsApi});

  @override
  Future<BannerAdsResponse> getBannerAdsAdmobKeys() {
    return bannerAdsApi.getBannerAdsAdmobKeys();
  }
}
