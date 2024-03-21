import 'package:app_shipper/src/models/cancel_order_model.dart';
import 'package:app_shipper/src/models/list_order_model/list_order_model.dart';
import 'package:app_shipper/src/models/list_order_model/list_order_statistic_model.dart';
import 'package:app_shipper/src/models/list_shop_model/list_shop_model.dart';
import 'package:app_shipper/src/models/support_model.dart';

import '../../models/detail_order_model/detail_order_model.dart';
import '../../models/shared_models/base_model.dart';

abstract class OrderRepository {
  Future<DetailOrderModel> getDetailOrderShipperById(
    String tokenlogin,
    String device_token,
    int order_id,
  );

  Future<ResponseCancelOrderModel> getCancelReasons();

  Future<BaseModel> updateStatusOrderByShipper(
    String tokenlogin,
    String device_token,
    int order_id,
    String order_status,
  );

  Future<BaseModel> setOnlineActive(
    String tokenlogin,
    String device_token,
    int active,
  );

  Future<ListOrderModel> getListCompletedOrdersShipper(
    String tokenlogin,
    String device_token,
    String? date,
    String? date_to,
    int page,
    int per_page,
  );

 Future<ListOrderStatisticModel> getListOrders(
    String tokenlogin,
    int page,
    int per_page,
     String order_status,
  );

  Future<BaseModel> cancelOrder(
    String tokenlogin,
    String device_token,
    int order_id,
    String reason,
  );

  Future<ListShopModel> getShopNearYou(String tokenlogin, String device_token,
      int page, int per_page, double? my_latitude, double? my_longtitude,
      [int? category_id, int? main_job]);

  Future<SupportModel> getSupportSettings();

}
