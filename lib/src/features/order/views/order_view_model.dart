import 'package:app_shipper/src/data/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:map4d_map/map4d_map.dart';

import '../../../base/base_view_model.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../di/injection/injection.dart';
import '../../../models/shared_models/shop.dart';
import '../../../shared/show_toast.dart';
import '../../../utils/helpers/logger.dart';
import 'dart:ui' as ui;

class OrderViewModel extends BaseViewModel with WidgetsBindingObserver{
  OrderViewModel(
      {required this.orderRepository, required this.profileRepository}) {
    getProfile();
    init();
    getActivityShipperInfo();
  }

  final OrderRepository orderRepository;
  final ProfileRepository profileRepository;

  MFMapType mapType = MFMapType.roadmap;
  List<Shop> shopNearYou = [];
  late MFMapViewController _mapController;
  Set<MFMarker> markers = {};
  MFBitmap? _markerIcon;
  late MFBitmap _makerItem;

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

  bool isLastPageShopNearYou = false;
  bool isLoadingShopNearYou = false;
  int pageShopNearYou = 1;

  Future<void> getShopNearYou() async {
    isLoadingShopNearYou = true;
    appData.myCurrentAddress ??= await geolocatorHelper.getCurrentPosition();

    final res = await orderRepository.getShopNearYou(
      appData.tokenLogin,
      appData.firebaseToken,
      pageShopNearYou,
      perPage,
      appData.myCurrentAddress?.latitude,
      appData.myCurrentAddress?.longitude,
    );
    if (res.status == true) {
      shopNearYou = res.list ?? [];
    }
    isLastPageShopNearYou =
        !(res.status ?? false) || (res.list?.isEmpty ?? true);

    isLoadingShopNearYou = false;
    notifyListeners();
    Logger.d('Shop gần bạn', shopNearYou.length);
  }



  void onMapCreated(MFMapViewController ctl) {
    _mapController = ctl;
    drawCurrentLocation();
    notifyListeners();
  }

  void drawCurrentLocation() async {
    EasyLoading.show();
    try {
      appData.myCurrentAddress = await geolocatorHelper.getCurrentPosition();
      _mapController.animateCamera(
        MFCameraUpdate.newCameraPosition(MFCameraPosition(
          target: MFLatLng(
            appData.myCurrentAddress?.latitude ?? 0,
            appData.myCurrentAddress?.longitude ?? 0,
          ),
          zoom: 14.0,
        )),
      );
      final myLocation = MFMarker(
        markerId: const MFMarkerId('my_location'),
        position: MFLatLng(
          appData.myCurrentAddress?.latitude ?? 0,
          appData.myCurrentAddress?.longitude ?? 0,
        ),
        zIndex: 1.0,
        icon: _markerIcon!,
      );
      markers.removeWhere((e) => e.markerId.value == 'my_location');
      Logger.d('Add marker', 'My location');
      markers.add(myLocation);
    } catch (e) {
      EasyLoading.dismiss();
    }
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addObserver(this);
    rootBundle.load("assets/images/point_3.png").then((data) async {
      ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: 80,
        targetHeight: 80,
      );
      ui.FrameInfo fi = await codec.getNextFrame();
      _markerIcon = MFBitmap.fromBytes(
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List(),
      );
    });
    rootBundle.load('assets/images/marker_icon.png').then((data) async {
      ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: 100,
        targetHeight: 100,
      );
      ui.FrameInfo fi = await codec.getNextFrame();
      _makerItem = MFBitmap.fromBytes(
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List(),
      );
    });
    appData.myCurrentAddress = await geolocatorHelper.getCurrentPosition();
  }

}
