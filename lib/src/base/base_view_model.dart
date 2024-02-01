import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../di/injection/injection.dart';
import '../shared/show_toast.dart';
import '../utils/helpers/logger.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _disposed = false;

  int page = 1;
  int perPage = 10;
  bool isLastPage = false;

  bool get isLoading => _loading;
  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  void openLinkGoogleMaps({String? lat, String? long, String? l}) async {
    if (l == null) {
      if (lat?.isEmpty == true || long?.isEmpty == true) {
        ShowToast.error('Toạ độ không chính xác. Vui lòng thử lại');
      }
    }
    final link =
        'https://www.google.com/maps/search/?api=1&query=${lat?.trim()},${long?.trim()}';
    Logger.d('MAP LINK', l ?? link);
    final openLink = await launchUrlString(
      l ?? link,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!openLink) {
      final reOpenLink = await launchUrlString(
        l ?? link,
        mode: LaunchMode.externalApplication,
      );
      if (!reOpenLink) {
        ShowToast.error('Có lỗi xảy ra. Vui lòng thử lại');
      }
    }
  }

  Future<String?> getShortLink(String? url) async {
    final data = {
      "dynamicLinkInfo": {
        "domainUriPrefix": "https://alotodayapp.page.link",
        "link": url,
        "androidInfo": {"androidPackageName": "com.booking.aloit"},
        "iosInfo": {
          "iosBundleId": "com.booking.aloit",
          "iosAppStoreId": "6446849546"
        }
      },
      "suffix": {"option": "SHORT"}
    };
    final res = await getIt<Dio>().post(
      'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyAabKEjT63m3bnAHdyKxLvQZdj56MQW1P4',
      data: data,
    );
    if (res.statusCode == 200) {
      return res.data['shortLink'];
    }
    return null;
  }
}
