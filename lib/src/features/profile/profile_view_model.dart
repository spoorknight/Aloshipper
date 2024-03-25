import 'package:app_shipper/src/models/list_review_shipper_model/review_shippeer_model.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/base_view_model.dart';
import '../../configs/app_constants.dart';
import '../../data/repositories/profile_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/hive/shipper_call_customer_adapter.dart';
import '../../models/list_service_new_model.dart';
import '../../navigator/routes.dart';
import '../../shared/show_toast.dart';
import '../../utils/helpers/logger.dart';

class ProfileViewModel extends BaseViewModel {
  final ProfileRepository profileRepo;

  ProfileViewModel({required this.profileRepo}) : super() {
    getData();
    scrollCrl.addListener(loadMore);
  }

  RefreshController refreshProfileCtl = RefreshController();


  final phiGiaoHangEC = TextEditingController();
  final phiKmDauTien = TextEditingController();
  final phiGoiXeEC = TextEditingController();
  final soTienCanThanhToanEC = TextEditingController();

  List<ReviewShipperModel> listReviewShipper = [];
  List<Packages> listService = [];

  RefreshController refreshCtl = RefreshController(initialRefresh: false);
  ScrollController scrollCrl = ScrollController();

  void getData() async {
    await Future.wait([
      getProfile(),
      getListReviewShipper(),
      getListServiceNewModel(),
    ]);
    initGoiDichVu();
  }

  void onRefresh() {
    page = 1;
    isLastPage = false;
    getListReviewShipper();
    refreshCtl.refreshCompleted();
  }

  Future<void> onRefreshProfile() async {
    await getProfile();
    refreshProfileCtl.refreshCompleted();
  }

  Future<void> getProfile() async {
    setLoading = true;
    try {
      final res = await profileRepo.getProfileShopApi(
        appData.tokenLogin,
        appData.firebaseToken,
      );
      if (res.status == true) {
        appData.profile.add(res);
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

  Future<void> update(
    String batGoiXe,
    String batNhanHang,
  ) async {
    EasyLoading.show();
    try {
      final res = await profileRepo.updateStatusOrderShipper(
        appData.tokenLogin,
        batGoiXe,
        batNhanHang,
      );
      if (res.status == true) {
        final resProfileRepo = await profileRepo.getProfileShopApi(
          appData.tokenLogin,
          appData.firebaseToken,
        );
        if (resProfileRepo.status == true) {
          appData.profile.add(resProfileRepo);
           // ShowToast.success(res.mess);
        } else {
          ShowToast.error(resProfileRepo.mess);
        }
      } else {
        ShowToast.error(res.mess);
      }
    } catch (e) {
      Logger.d('GET PROFILE >>>', e);
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  // Future<void> getListServiceModel() async {
  //   setLoading = true;
  //   try {
  //     final res = await profileRepo.getListServiceModel(
  //       appData.tokenLogin,
  //       appData.firebaseToken,
  //     );
  //     if (res.list != null) {
  //       listService = (res.list ?? [])
  //           .where((element) => (element.price ?? 0) > 0)
  //           .toList();
  //     }
  //   } catch (e) {
  //     Logger.d('GET LIST SERVICE MODEL >>>', e);
  //   } finally {
  //     setLoading = false;
  //     notifyListeners();
  //   }
  // }

  ListServiceNewModel? listServiceModel;
  Future<void> getListServiceNewModel() async {
    setLoading = true;
    try {
      final res = await profileRepo.getListServiceNewModel(
        appData.tokenLogin,
      );
      if (res.packages != null) {
        listServiceModel = res;
        listService = (res.packages ?? [])
            .where((element) => (double.parse(element.price?? '0')) > 0)
            .toList();
      }
    } catch (e) {
      Logger.d('GET LIST SERVICE MODEL >>>', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  // Future<void> updatePhiGiaoHang() async {
  //   EasyLoading.show();
  //   try {
  //     final res = await profileRepo.updatePhiGiaoHang(
  //       appData.tokenLogin,
  //       appData.firebaseToken,
  //       phiGiaoHangEC.text.removeComma,
  //     );
  //     if (res.status == true) {
  //       phiGiaoHangEC.clear();
  //       AppNavigator.pop(true);
  //     } else {
  //       ShowToast.error(res.mess ?? res.item);
  //     }
  //   } catch (e) {
  //     Logger.d('updatePhiGoiXe >>>', e);
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  Future<void> updatePhiGoiXe() async {
    EasyLoading.show();
    try {
      final res = await profileRepo.updatePhiGoiXe(
        appData.tokenLogin,
        appData.firebaseToken,
        phiGoiXeEC.text.removeComma,
      );
      if (res.status == true) {
        phiGoiXeEC.clear();
        AppNavigator.pop(true);
      } else {
        ShowToast.error(res.mess ?? res.item);
      }
    } catch (e) {
      Logger.d('updatePhiGoiXe >>>', e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> updatePhiKmDauTien() async {
    EasyLoading.show();
    try {
      final res = await profileRepo.updatePhiKmDauTien(
        appData.tokenLogin,
        appData.firebaseToken,
        phiKmDauTien.text.removeComma,
      );
      if (res.status == true) {
        phiKmDauTien.clear();
        AppNavigator.pop(true);
      } else {
        ShowToast.error(res.mess ?? res.item);
      }
    } catch (e) {
      Logger.d('updatePhiKmDauTien >>>', e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getListReviewShipper() async {
    setLoading = true;
    try {
      final res = await profileRepo.getListReviewShipper(
        appData.tokenLogin,
        appData.firebaseToken,
        page,
        perPage,
      );
      if (res.status == true) {
        listReviewShipper = res.list ?? [];
      }
    } catch (e) {
      Logger.d('GET LIST REVIEW SHIPPER >>>', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    try {
      if (scrollCrl.position.pixels == scrollCrl.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          final res = await profileRepo.getListReviewShipper(
            appData.tokenLogin,
            appData.firebaseToken,
            page,
            perPage,
          );
          if (res.status == true) {
            listReviewShipper.addAll(res.list ?? []);
            isLastPage = !(res.status ?? false) || (res.list?.isEmpty ?? true);
          } else {
            isLastPage = true;
          }
          notifyListeners();
        }
      }
    } catch (e) {
      Logger.d('LOAD MORE >>>', e);
    }
  }

  Future<void> autoGiaHan(bool active) async {
    if(listServiceModel?.currentPackageOfUser?.isDeleted == '1'){
      EasyLoading.showError(listServiceModel?.packageIsRemovedMess ?? "");
      return;
    }
    if(listServiceModel?.currentPackageOfUser?.isDefault == '1'){
      EasyLoading.showError(listServiceModel?.cannotAutoRenewPackageMess ?? "");
      return;
    }

    EasyLoading.show();
    try {
      final res = await profileRepo.autoGiaHan(
        appData.tokenLogin,
        appData.firebaseToken,
        active ? 1 : 0,
      );
      if (res.status == true) {
        // appData.profile.valueOrNull?.item?.user?.giaHanTuDong = active ? '1' : '0';
        final res = await profileRepo.getProfileShopApi(
          appData.tokenLogin,
          appData.firebaseToken,
        );
        if (res.status == true) {
          // appData.profile = res;
          appData.profile.add(res);
        } else {
          ShowToast.error(res.mess);
        }
      } else {
        ShowToast.error(res.mess ?? res.item);
      }
    } catch (e) {
      Logger.d('AUTO GIA HAN >>>', e);
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  String? selectedPlanId;

  void onSelectPlan(Packages ser) {
    selectedPlanId = ser.id;
    soTienCanThanhToanEC.text = ser.price.toString().toVnd;
    notifyListeners();
  }

  // void thanhToanGoiDichVu() async {
  //   if (selectedPlanId == null) {
  //     EasyLoading.showToast('Bạn chưa chọn gói dịch vụ');
  //   } else {
  //     EasyLoading.show();
  //     try {
  //       final res = await profileRepo.thanhToanGoiDichVu(
  //         appData.tokenLogin,
  //         appData.firebaseToken,
  //         int.parse(selectedPlanId ?? ''),
  //       );
  //       if (res.status == true) {
  //         await getProfile();
  //         ShowToast.success(res.mess ?? res.item);
  //         AppNavigator.pop();
  //       } else {
  //         ShowToast.error(res.mess ?? res.item);
  //       }
  //     } catch (e) {
  //       Logger.d('THANH TOAN GOI DICH VU >>>', e);
  //     } finally {
  //       EasyLoading.dismiss();
  //       notifyListeners();
  //     }
  //   }
  // }

  void thanhToanGoiDichVu(String? planId) async {
    if (planId == null) {
      EasyLoading.showToast('Bạn chưa chọn gói dịch vụ');
    } else {
      EasyLoading.show();
      try {
        final res = await profileRepo.thanhToanGoiDichVu(
          appData.tokenLogin,
          appData.firebaseToken,
          int.parse(planId ?? ''),
        );
        if (res.status == true) {
          await getProfile();
          ShowToast.success(res.mess ?? res.item);
          AppNavigator.pop();
        } else {
          ShowToast.error(res.mess ?? res.item);
        }
      } catch (e) {
        Logger.d('THANH TOAN GOI DICH VU >>>', e);
      } finally {
        EasyLoading.dismiss();
        notifyListeners();
      }
    }
  }

  void initGoiDichVu() {
    if (listService
        .any((e) => e.id == appData.profile.valueOrNull?.plan?.planId)) {
      selectedPlanId = appData.profile.valueOrNull?.plan?.planId;
      soTienCanThanhToanEC.text =
          appData.profile.valueOrNull?.plan?.price?.toVnd ?? '';
    } else {
      selectedPlanId = null;
      soTienCanThanhToanEC.clear();
    }
    notifyListeners();
  }

  Future<void> shareLinkSuccess() async {
    try {
      EasyLoading.show();
      final res = await profileRepo.shareLinkStore(
          appData.tokenLogin, appData.profile.valueOrNull?.memberId ?? '', '1');
      if (res.status == true) {
        ShowToast.success(res.mess ?? 'Thành công');
      } else {
        ShowToast.error(res.mess ?? 'Thất bại');
      }
    } catch (e) {
      Logger.d('shareLink Error', e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void updateToaDo() async {
    EasyLoading.show();
    try {
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
    } catch (e) {
      Logger.d('UPDATE LOCATION >>>', e);
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  void logOut() async {
    EasyLoading.show();
    try {
      await ShipperCallCustomerModel().clear();
      await _clearData();
      Future.delayed(const Duration(milliseconds: 1500), () {
        EasyLoading.dismiss();
        AppNavigator.pushAndRemoveUntil(Routes.loginScreen);
      });
    } catch (e) {
      Logger.d('DANG XUAT >>>', e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> _clearData() async {
    try {
      appData.clear();
      await dataManager.removeValue(AppConstants.userName);
      await dataManager.removeValue(AppConstants.password);
      await dataManager.removeValue(AppConstants.rememberMe);
      Logger.d('CLEAR TOKEN LOGIN >>>', appData.tokenLogin);
    } catch (e) {
      Logger.d('CLEAR TOKEN LOGIN >>>', e);
    }
  }

  void deleteAccount() async {
    EasyLoading.show();
    try {
      final res = await profileRepo.deleteAccount(
        appData.tokenLogin,
        appData.firebaseToken,
      );
      if (res.status == true) {
        await _clearData();
        AppNavigator.pushAndRemoveUntil(Routes.loginScreen);
        ShowToast.success(res.mess ?? res.item);
      } else {
        AppNavigator.pop();
        ShowToast.error(res.mess ?? res.item);
      }
    } catch (e) {
      Logger.d('AUTO GIA HAN >>>', e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
