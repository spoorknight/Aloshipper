import 'package:app_shipper/src/base/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../data/repositories/banner_repository.dart';
import '../../models/banner_ads_model.dart';

class BannerAdsViewModel extends BaseViewModel {
  final BannerRepository bannerRepo;

  BannerAdsViewModel({
    required this.bannerRepo,
  }) : super() {
    getBannerAdsAdmobKeys();
  }

  BannerAdsModel? bannerAdsModel;

  Future<void> getBannerAdsAdmobKeys() async {
    try {
      final res = await bannerRepo.getBannerAdsAdmobKeys();
      if (res.status == true) {
        bannerAdsModel = res.data;
      }
    } catch (e) {
    } finally {}
  }
}
