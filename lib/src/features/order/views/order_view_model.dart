import 'package:app_shipper/src/data/repositories/profile_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../base/base_view_model.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../di/injection/injection.dart';
import '../../../shared/show_toast.dart';
import '../../../utils/helpers/logger.dart';

class OrderViewModel extends BaseViewModel {
  OrderViewModel(
      {required this.orderRepository, required this.profileRepository}) {
    getProfile();
    getActivityShipperInfo();
  }

  final OrderRepository orderRepository;
  final ProfileRepository profileRepository;

  Future<void> getActivityShipperInfo() async {
    try {
      final res = await profileRepository.getActivityShipperInfo();
      if (res.status == true) {
        appData.userInfoActiveModel = res;
      } else {
        ShowToast.error(res.mess);
      }
    } catch (e) {
      Logger.d('GET PROFILE >>>', e);
    } finally {
      notifyListeners();
    }
  }

  Future<bool> setOnlineActive(bool active) async {
    setLoading = true;
    try {
      final res = await orderRepository.setOnlineActive(
          appData.tokenLogin, appData.firebaseToken, active ? 1 : 0);
      setLoading = false;
      getActivityShipperInfo();
      notifyListeners();
      if (res.status == true) {
        ShowToast.success(res.mess ?? "");
        return active;
      } else {
        ShowToast.error(res.mess ?? "");
        return !active;
      }
    } catch (e) {
      Logger.d('SET ONLINE ACTICE >>>', e);
      ShowToast.error("Có lỗi xảy ra");
      setLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getProfile() async {
    setLoading = true;
    try {
      final res = await profileRepository.getProfileShopApi(
        appData.tokenLogin,
        appData.firebaseToken,
      );
      if (res.status == true) {
        appData.profile.add(res);
        appData.autoUpdateLocation();
      } else {
        ShowToast.error(res.mess);
      }
    } catch (e) {
      Logger.d('GET PROFILE >>>', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }
}
