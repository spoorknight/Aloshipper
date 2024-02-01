import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/collaborate_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/list_store_recommend_model/list_store_recommend_model.dart';
import '../../utils/helpers/logger.dart';

class StoreRecommendViewModel extends BaseViewModel {
  final CollaborateRepository collabRepo;

  StoreRecommendViewModel({
    required this.collabRepo,
  }) : super() {
    getListStoreRecommend();
  }

  List<StoreRecommendModel> listStoreRecommend = [];

  DateTime? date;
  String? selectedStatus;

  TextEditingController dateCtl = TextEditingController();

  RefreshController refreshCtl = RefreshController();
  ScrollController scrollCrl = ScrollController();

  List<Tuple2<String, String>> listStatus = const [
    Tuple2('Hoàn thành', 'completed'),
    Tuple2('Mới đăng ký', 'suppend'),
    Tuple2('Từ chối', ' cancelled'),
  ];

  void onRefresh() {
    page = 1;
    isLastPage = false;
    dateCtl.clear();
    date = null;
    selectedStatus = null;
    getListStoreRecommend();
    refreshCtl.refreshCompleted();
  }

  Future<void> getListStoreRecommend() async {
    setLoading = true;
    try {
      final res = await collabRepo.getListStoreRecommend(
        appData.tokenLogin,
        appData.firebaseToken,
        page,
        perPage,
        dateCtl.text,
        selectedStatus,
      );
      if (res.status == true) {
        listStoreRecommend = res.list ?? [];
      }
    } catch (e) {
      Logger.d('AUTO GIA HAN >>>', e);
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
          final res = await collabRepo.getListStoreRecommend(
            appData.tokenLogin,
            appData.firebaseToken,
            page,
            perPage,
            dateCtl.text,
            selectedStatus,
          );
          if (res.status == true) {
            listStoreRecommend.addAll(res.list ?? []);
            isLastPage = !(res.status ?? false) || (res.list?.isEmpty ?? true);
          } else {
            isLastPage = true;
          }
        }
      }
      notifyListeners();
    } catch (e) {
      Logger.d('LOAD MORE >>>', e);
    }
  }

  void onChangeStatus(String value) {
    selectedStatus = value;
    getListStoreRecommend();
    notifyListeners();
  }

  void selectDate(DateTime newDate) {
    date = newDate;
    dateCtl.text = DateFormat('dd/MM/yyyy').format(newDate);
    getListStoreRecommend();
    notifyListeners();
  }
}
