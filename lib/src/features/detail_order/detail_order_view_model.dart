import 'package:app_shipper/src/data/data_sources/local/app_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/detail_order_model/detail_order_model.dart';
import '../../models/list_order_model/order_firebase_model.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../shared/show_toast.dart';
import '../../utils/constants.dart';
import '../../utils/helpers/logger.dart';
import '../../utils/permission_helper/app_permission.dart';

class DetailOrderViewModel extends BaseViewModel {
  final OrderRepository orderRepo;
  final ProfileRepository profileRepo;

  DetailOrderViewModel({
    required this.orderRepo,
    required this.profileRepo,
  }) : super() {
    getDetailOrder();
  }

  DetailOrderModel? detailOrder;
  String? order_id;
  DatabaseReference ref = FirebaseDatabase.instance.ref(Constants.refOrderList);

  Map<String, dynamic> orderIsCall = {};

  bool checkOrderIsCalled(String orderId) {
    try {
      if (orderIsCall.containsKey(orderId)) {
        return orderIsCall[orderId];
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void setOrderIsCalled(String orderId) {
    try {
      orderIsCall[orderId] = true;
    } catch (e) {}
    notifyListeners();
  }

  void setOrderId(String? id) {
    order_id = id;
    notifyListeners();
  }

  Future getDetailOrder() async {
    setLoading = true;
    try {
      final res = await orderRepo.getDetailOrderShipperById(
        appData.tokenLogin,
        appData.firebaseToken,
        int.parse(order_id ?? ''),
      );
      setLoading = false;
      notifyListeners();
      if (res.status == true) {
        detailOrder = res;

        ref.orderByChild("order_id").equalTo(order_id).onValue.listen((event) {
          if (event.snapshot.value != null) {
            OrderFirebaseModel order =
                OrderFirebaseModel.fromJson(event.snapshot.value);
            if (order.shipper?.id != null && order.shipper?.id != appData.userId) {
              AppNavigator.popUntil(Routes.mainScreen);
            }
          }
        });

        notifyListeners();
        return true;
      } else {
        ShowToast.error(res.mess?.toString());
        return false;
      }
    } catch (e) {
      Logger.d('GET DETAIL ORDER >>>', e);
      setLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateStatus(String status) async {
    setLoading = true;
    try {
      final res = await orderRepo.updateStatusOrderByShipper(
        appData.tokenLogin,
        appData.firebaseToken,
        int.parse(order_id ?? ''),
        status,
      );
      if (res.status == true) {
        await getDetailOrder();
        orderIsCall.remove(order_id);
      } else {
        ShowToast.error(res.mess ?? res.item);
      }
    } catch (e) {
      Logger.d('UPDATE STATUS ORDER >>>', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLocation() async {
    try {
      GrantPermissionLocationStrategy().request(
        onGranted: () async {
          EasyLoading.show();
          final location = await geolocatorHelper.getCurrentPosition();

          final res = await profileRepo.updateToaDo(
            appData.tokenLogin,
            location?.latitude,
            location?.longitude,
          );
          if (res.status == true) {
            ShowToast.success(res.mess ?? res.item);
          } else {
            ShowToast.error(res.mess ?? res.item);
          }
          EasyLoading.dismiss();
          notifyListeners();
        },
        onDenied: appData.showDialogOpenAppSettings,
        onPermanentlyDenied: appData.showDialogOpenAppSettings,
      );
    } catch (e) {}
  }

  Future<void> cancelOrder(String reason) async {
    EasyLoading.show();
    try {
      final res = await orderRepo.cancelOrder(
        appData.tokenLogin,
        appData.firebaseToken,
        int.parse(order_id ?? ''),
        reason,
      );
      if (res.status == true) {
        await getDetailOrder();
      } else {
        ShowToast.error(res.mess ?? res.item);
      }
      AppNavigator.pop();
    } catch (e) {
      Logger.d('CANCEL ORDER >>>', e);
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
