import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hive/shipper_call_customer_adapter.dart';
import '../injection/injection.dart';



const CALL_CUSTOMER = 'call_customer';

class HiveModules extends DIModule {
  @override
  Future<void> register() async {
    // Khởi tạo và mở hộp Hive
    await Hive.initFlutter();


    Hive.registerAdapter(ShipperCallCustomerModelAdapter());

    await Hive.openBox<ShipperCallCustomerModel>(CALL_CUSTOMER);

    getIt.registerSingleton<Box<ShipperCallCustomerModel>>(Hive.box<ShipperCallCustomerModel>(CALL_CUSTOMER));
  }
}
