import '../../models/list_bought_customer_model/list_hoa_hong_model.dart';
import '../../models/collaborate_info_model/collaborate_info_model.dart';
import '../../models/list_discount_product_model/list_discount_product_model.dart';
import '../../models/list_store_recommend_model/list_store_recommend_model.dart';

abstract class CollaborateRepository {
  Future<CollaborateInfoModel> getCollbabInfo(
      String tokenlogin, String device_token);

  Future<ListBoughtCustomerModel> getBoughtCustomers(
    String tokenlogin,
    String device_token,
    int page,
    int per_page,
    String? date,
    String? status,
  );

  Future<ListDiscountProductModel> getListDiscountProduct(
    String tokenlogin,
    String device_token,
    int page,
    int per_page,
  );

  Future<ListStoreRecommendModel> getListStoreRecommend(
    String tokenlogin,
    String device_token,
    int page,
    int per_page,
    String? date,
    String? status,
  );

  Future<String?> getShortLink(String? url);
}
