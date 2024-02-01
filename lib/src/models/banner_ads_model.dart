import 'dart:io';

class BannerAdsResponse {
  bool? status;
  String? mess;
  BannerAdsModel? data;

  BannerAdsResponse({this.status, this.mess, this.data});

  BannerAdsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    data = json['data'] != null ? BannerAdsModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['mess'] = mess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BannerAdsModel {
  String? bannerAdsAlotodayIos;
  String? bannerAdsAlotodayAndroid;
  String? bannerAdsAloshipperIos;
  String? bannerAdsAloshipperAndroid;
  String? bannerAdsAlostoreIos;
  String? bannerAdsAlostoreAndroid;

  BannerAdsModel(
      {this.bannerAdsAlotodayIos,
        this.bannerAdsAlotodayAndroid,
        this.bannerAdsAloshipperIos,
        this.bannerAdsAloshipperAndroid,
        this.bannerAdsAlostoreIos,
        this.bannerAdsAlostoreAndroid});

  BannerAdsModel.fromJson(Map<String, dynamic> json) {
    bannerAdsAlotodayIos = json['banner_ads_alotoday_ios'];
    bannerAdsAlotodayAndroid = json['banner_ads_alotoday_android'];
    bannerAdsAloshipperIos = json['banner_ads_aloshipper_ios'];
    bannerAdsAloshipperAndroid = json['banner_ads_aloshipper_android'];
    bannerAdsAlostoreIos = json['banner_ads_alostore_ios'];
    bannerAdsAlostoreAndroid = json['banner_ads_alostore_android'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_ads_alotoday_ios'] = bannerAdsAlotodayIos;
    data['banner_ads_alotoday_android'] = bannerAdsAlotodayAndroid;
    data['banner_ads_aloshipper_ios'] = bannerAdsAloshipperIos;
    data['banner_ads_aloshipper_android'] = bannerAdsAloshipperAndroid;
    data['banner_ads_alostore_ios'] = bannerAdsAlostoreIos;
    data['banner_ads_alostore_android'] = bannerAdsAlostoreAndroid;
    return data;
  }

  String get getBannerAdsKey {
    if (Platform.isAndroid) {
      return bannerAdsAloshipperAndroid ?? '';
    } else if (Platform.isIOS) {
      return bannerAdsAloshipperIos ?? '';
    } else {
      return '';
    }
  }
}
