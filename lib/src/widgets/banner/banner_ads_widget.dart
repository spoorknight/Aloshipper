import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../shared/viewModels/banner_ads_view_model.dart';

class BannerAdsWidget extends StatefulWidget {
  const BannerAdsWidget({super.key});

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
  BannerAd? bannerAd;
  final AdSize adSize = const AdSize(width: 375, height: 90);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerAdsViewModel>(builder: (context, viewModel, _) {
      if (bannerAd == null && viewModel.bannerAdsModel != null) {
        loadAd(viewModel.bannerAdsModel!.getBannerAdsKey);
      }
      if (bannerAd != null) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: bannerAd!.size.width.toDouble(),
            height: bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: bannerAd!),
          ),
        );
      }
      return const SizedBox();
    });
  }

  /// Loads a banner ad.
  void loadAd(String adUnitId) {
    try {
      bannerAd = BannerAd(
        adUnitId: adUnitId,
        request: const AdRequest(),
        size: adSize,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            setState(() {});
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            debugPrint('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },
        ),
      )..load();
    } catch (e) {
      debugPrint('BannerAd catch: $e');
    }
  }
}
