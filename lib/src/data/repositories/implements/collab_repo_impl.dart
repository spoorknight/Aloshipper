import 'package:dio/dio.dart';

import '../../../di/injection/injection.dart';
import '../../../models/collaborate_info_model/collaborate_info_model.dart';
import '../../../models/list_bought_customer_model/list_hoa_hong_model.dart';
import '../../../models/list_discount_product_model/list_discount_product_model.dart';

import '../../../models/list_store_recommend_model/list_store_recommend_model.dart';
import '../../data_sources/remote/collab_api.dart';
import '../collaborate_repository.dart';

class CollabRepoImpl implements CollaborateRepository {
  final CollabApi collabApi;
  const CollabRepoImpl({required this.collabApi});

  @override
  Future<CollaborateInfoModel> getCollbabInfo(
      String tokenlogin, String device_token) {
    return collabApi.getCollbabInfo(tokenlogin, device_token);
  }

  @override
  Future<ListBoughtCustomerModel> getBoughtCustomers(
    String tokenlogin,
    String device_token,
    int page,
    int per_page,
    String? date,
    String? status,
  ) {
    return collabApi.getBoughtCustomer(
        tokenlogin, device_token, page, per_page, date, status);
  }

  @override
  Future<ListDiscountProductModel> getListDiscountProduct(
      String tokenlogin, String device_token, int page, int per_page) {
    return collabApi.getListDiscountProduct(
        tokenlogin, device_token, page, per_page);
  }

  @override
  Future<ListStoreRecommendModel> getListStoreRecommend(
      String tokenlogin,
      String device_token,
      int page,
      int per_page,
      String? date,
      String? status) {
    return collabApi.getListStoreRecommend(
        tokenlogin, device_token, page, per_page, date, status);
  }

  @override
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
