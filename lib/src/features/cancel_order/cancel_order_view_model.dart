import 'package:app_shipper/src/base/base_view_model.dart';
import 'package:app_shipper/src/data/repositories/order_repository.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/models/cancel_order_model.dart';
import 'package:app_shipper/src/shared/show_toast.dart';
import 'package:app_shipper/src/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CancelOrderViewModel extends BaseViewModel {
  final OrderRepository orderRepo;

  CancelOrderViewModel({required this.orderRepo}) : super() {
    getListReason();
  }

  TextEditingController cancelReasonCtl = TextEditingController();
  List<ReasonCancelOrderModel> lstReason = [];
  bool isLoading = false;
  String? reasonCancelSelected;
  final ReasonCancelOrderModel otherReasonCancel =
      ReasonCancelOrderModel(id: '0', content: 'Lý do khác');

  Future<void> getListReason() async {
    try {
      isLoading = true;
      final res = await orderRepo.getCancelReasons();
      if (res.status == true) {
        lstReason = res.data ?? [];
      }
    } catch (e) {
      debugPrint('error getListReason: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sendReasonCancel(String? orderId) async {
    EasyLoading.show();
    try {
      String reason = cancelReasonCtl.text;

      if (reasonCancelSelected != null && reasonCancelSelected != otherReasonCancel.id) {
        reason = lstReason
                .firstWhere((element) => element.id == reasonCancelSelected)
                .content ??
            '';
      }

      final res = await orderRepo.cancelOrder(
        appData.tokenLogin,
        appData.firebaseToken,
        int.parse(orderId ?? ''),
        reason,
      );
      EasyLoading.dismiss();
      if (res.status == true) {
        ShowToast.success(res.mess ?? 'Hủy đơn thành công');
        return true;
      } else {
        ShowToast.error(res.mess ?? res.item);
        return false;
      }
    } catch (e) {
      Logger.d('CANCEL ORDER >>>', e);
      ShowToast.error('Đã có lỗi xảy ra.');
      EasyLoading.dismiss();
      return false;
    }
  }

  void selectReason(ReasonCancelOrderModel value) {
    reasonCancelSelected = value.id;
    notifyListeners();
  }
}
