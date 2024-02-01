import 'package:app_shipper/src/data/repositories/order_repository.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/utils/app_enum.dart';
import 'package:app_shipper/src/utils/constants.dart';
import 'package:app_shipper/src/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/list_order_model/order_firebase_model.dart';
import '../navigator/routes.dart';
import '../shared/dialog.dart';

class AppViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  bool isOpenDialog = false;

  /// bởi vì lúc update việc hủy đơn dưới BE có tể bị chậm => nó sẽ pop trang cancel => chưa thể đóng popup
  bool isCancel = false;

  AppViewModel({required this.orderRepository}) {
    final orderAdded = database.ref(Constants.refOrderList).onChildAdded;
    final orderChange = database.ref(Constants.refOrderList).onChildChanged;
    final orderRemove = database.ref(Constants.refOrderList).onChildRemoved;
    orderAdded.listen(checkAlertOrder);
    orderChange.listen(checkAlertOrder);
    orderRemove.listen(
      (event) {
        closeDialog();
      },
    );
  }

  void checkAlertOrder(DatabaseEvent event) {
    OrderFirebaseModel order =
        OrderFirebaseModel.fromJson(event.snapshot.value);

    if (order.shipperId != appData.userId && isOpenDialog) {
      closeDialog();
    }

    if (order.shipperId == appData.userId &&
        (order.orderStatus == OrderStatusEnum.confirm.name ||
            order.orderStatus == OrderStatusEnum.wait_shipper.name)) {
      isOpenDialog = true;
      showDialog(
          context: AppNavigator.navigatorKey.currentState!.overlay!.context,
          builder: (BuildContext ctx) {
            return DialogConfirmQuestion(
              key: _dialogKey,
              typeOrder: order.type ?? '',
              resetTime: Utils().calculatorTimeResetTime(
                resetTime: order.getResetTime.toInt(),
                updateAt: order.updateAt,
              ),
              actionCancel: () async {
                EasyLoading.show();

                detailOrderViewModel.order_id = order.orderId;
                final res = await detailOrderViewModel.getDetailOrder();

                EasyLoading.dismiss();
                if (res == true) {
                  isCancel = true;
                  final res = await AppNavigator.push(Routes.cancelOrderScreen);
                  if (res == true) {
                    isCancel = false;
                    closeDialog();
                  }
                }
              },
              action: () async {
                EasyLoading.show();

                final res = await orderRepository.updateStatusOrderByShipper(
                  appData.tokenLogin,
                  appData.firebaseToken,
                  int.parse(order.orderId.toString()),
                  order.type == Constants.TYPE_MUA_HANG
                      ? OrderStatusEnum.shipper_received_order.name
                      : OrderStatusEnum.shipper_confirm.name,
                );

                EasyLoading.dismiss();
                if (res.status == true) {
                  closeDialog();
                } else {
                  showDialog(
                    context: AppNavigator
                        .navigatorKey.currentState!.overlay!.context,
                    builder: (ctxChild) => DialogError(
                      mess: res.mess ?? res.item ?? "Đã có lỗi xảy ra",
                      action: () {
                        Navigator.pop(ctxChild);
                        closeDialog();
                      },
                    ),
                  );
                }
              },
            );
          });
    }
  }

  closeDialog() {
    final currentContext = _dialogKey.currentContext;
    if (currentContext != null && isCancel == false) {
      isOpenDialog = false;
      Navigator.of(currentContext).pop();
    }
  }
}
