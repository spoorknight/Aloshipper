import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../di/injection/injection.dart';

part 'shipper_call_customer_adapter.g.dart';

@HiveType(typeId: 0)
class ShipperCallCustomerModel extends HiveObject {
  @HiveField(0)
  String? orderId;

  @HiveField(1)
  DateTime? created;

  @HiveField(2)
  bool isCalled = false;

  @HiveField(3)
  String? phoneNumber;

  // Override phương thức key để Hive biết cách tạo khóa từ đối tượng
  @override
  dynamic key =
      'shipper_call_customer'; // Khóa mẫu, bạn có thể tùy chỉnh theo cách bạn muốn

  checkPhoneExist(String phoneNum) {
    try {
      final data = shipperCallCustomerAdapter.toMap();
      if (data.containsKey(phoneNum)) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  remove(String orderId) async {
    try {
      await shipperCallCustomerAdapter.delete(orderId);
    } catch (e) {
      debugPrint('remove hive error');
    }
  }

  Future<void> clear() async {
    try {
      await shipperCallCustomerAdapter.clear();
    } catch (e) {
      debugPrint('clear hive error');
    }
  }

  saveCallInfo({required String orderId, String? phoneNum}) {
    try {
      var data = ShipperCallCustomerModel()
        ..orderId = orderId
        ..created = DateTime.now()
        ..phoneNumber = phoneNum;
      shipperCallCustomerAdapter.put(orderId, data);
    } catch (e) {
      debugPrint('saveCallInfo hive error');
    }
  }
}
