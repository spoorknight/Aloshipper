import 'package:app_shipper/src/models/cancel_order_model.dart';
import 'package:app_shipper/src/models/list_order_model/list_order_model.dart';

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

  Future<BaseModel> cancelOrder(
    String tokenlogin,
    String device_token,
    int order_id,
    String reason,
  );
}
