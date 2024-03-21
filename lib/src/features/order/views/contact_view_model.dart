import 'dart:async';


import 'package:app_shipper/src/base/base_view_model.dart';
import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/data/repositories/order_repository.dart';
import 'package:app_shipper/src/models/support_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../di/injection/injection.dart';
import '../../../utils/helpers/logger.dart';

class ContactViewModel extends BaseViewModel {
  final OrderRepository orderRepo;

  ContactViewModel({required this.orderRepo}) : super() {
    getSupportSettings();
  }

  double minOpacity = 0.5;
  double maxOpacity = 1;

  bool isDraggingLeft = false;
  Offset dragOffset = Offset(310.w, 560.h);
  double maxX = 0;
  double minY = 0;
  double maxY = 0;

  bool showButtonContact = false;

  void showFloatingButtons() {
    showButtonContact = true;
    notifyListeners();
  }

  void hideFloatingButtons() {
    showButtonContact = false;
    notifyListeners();
  }

  // StreamController<Offset> dragEndPositionStreamController =
  //     StreamController<Offset>.broadcast();

  final onDragFloatButtonStreamController = BehaviorSubject<double>.seeded(0);
  List<SupportDataModel> listSupportData= [];

  Future<void> getSupportSettings() async {
    try {
      final res = await orderRepo.getSupportSettings();
      if (res.status == true) {
        appData.lstSupportDataModel = res.data ?? [];
        listSupportData = res.data ?? [];
      }
    } catch (e) {
      Logger.d('Error getSupportSettings', e);
    }
    notifyListeners();
  }
}
