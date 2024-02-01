import 'package:app_shipper/src/models/cancel_order_model.dart';
import 'package:app_shipper/src/models/list_order_model/list_order_model.dart';
import 'package:app_shipper/src/models/shared_models/base_model.dart';

import '../../data_sources/remote/order_api.dart';
import '../order_repository.dart';
import '../../../models/detail_order_model/detail_order_model.dart';

class OrderRepoImpl implements OrderRepository {
  final OrderApi orderApi;
  const OrderRepoImpl({required this.orderApi});

  @override
  Future<DetailOrderModel> getDetailOrderShipperById(String tokenlogin, String device_token, int order_id) {
    return orderApi.getDetailOrderShipperById(tokenlogin, device_token, order_id);
  }

  @override
  Future<BaseModel> updateStatusOrderByShipper(
      String tokenlogin, String device_token, int order_id, String order_status) {
    return orderApi.updateStatusOrderByShipper(tokenlogin, device_token, order_id, order_status);
  }

  @override
  Future<BaseModel> setOnlineActive(String tokenlogin, String device_token, int active) {
    return orderApi.setOnlineActive(tokenlogin, device_token, active);
  }

  @override
  Future<ListOrderModel> getListCompletedOrdersShipper(
      String tokenlogin, String device_token, String? date, String? date_to, int page, int per_page) {
    return orderApi.getListCompletedOrdersShipper(tokenlogin, device_token, date, date_to, page, per_page);
  }

  @override
  Future<BaseModel> cancelOrder(
    String tokenlogin,
    String device_token,
    int order_id,
    String reason,
  ) {
    return orderApi.cancelOrder(tokenlogin, device_token, order_id, reason);
  }

  @override
  Future<ResponseCancelOrderModel> getCancelReasons() {
    return orderApi.getCancelReasons();
  }
}
