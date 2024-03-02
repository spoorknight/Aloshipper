import 'package:app_shipper/src/base/base_view_model.dart';
import 'package:app_shipper/src/data/repositories/order_repository.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/models/list_order_model/list_order_statistic_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/list_order_model/order.dart';
import '../../utils/helpers/logger.dart';

class StatisticViewModel extends BaseViewModel {
  final OrderRepository orderRepo;

  StatisticViewModel({required this.orderRepo}) : super() {
    getOrderCompleted();
    getOrderCancel();
    scrollCrl.addListener(loadMoreOrderCompleted);
    scrollCrlCancel.addListener(loadMoreOrderCancel);
  }

  // final fromDateEC = TextEditingController();
  // final toDateEC = TextEditingController();
  // DateTime? fromDate;
  // DateTime? toDate;
  List<OrderStatisticModel> ordersCancel = [];
  List<OrderStatisticModel> ordersCompleted = [];

  RefreshController refreshCtl = RefreshController(initialRefresh: false);
  ScrollController scrollCrl = ScrollController();

  void onRefreshCompleted() {
    page = 1;
    isLastPage = false;
    getOrderCompleted();
    refreshCtl.refreshCompleted();
  }

  Future<void> getOrderCompleted() async {
    setLoading = true;
    try {
      final res = await orderRepo.getListOrders(
        appData.tokenLogin,
        page,
        perPage,
        "completed"
      );
      if (res.status == true) {
        ordersCompleted = res.data!;
      } else {
        ordersCompleted = [];
      }
    } catch (e) {
      Logger.d('GET STATISTIC >>>', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreOrderCompleted() async {
    try {
      if (scrollCrl.position.pixels == scrollCrl.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          final res = await orderRepo.getListOrders(
            appData.tokenLogin,
            page,
            perPage,
            "completed"
          );
          if (res.status == true) {
            ordersCompleted.addAll(res.data ?? []);
            isLastPage = !(res.status ?? false) || (res.data?.isEmpty ?? true);
          } else {
            isLastPage = true;
          }
        }
      }
    } catch (e) {
      Logger.d('LOAD MORE >>>', e);
    } finally {
      notifyListeners();
    }
  }

  // void selectFromDate(DateTime newDate) {
  //   fromDate = newDate;
  //   fromDateEC.text = DateFormat('dd/MM/yyyy').format(newDate);
  //   if (toDate != null) {
  //     page = 1;
  //     getOrderCompleted();
  //   }
  //   notifyListeners();
  // }
  //
  // void selectToDate(DateTime newDate) {
  //   toDate = newDate;
  //   toDateEC.text = DateFormat('dd/MM/yyyy').format(newDate);
  //   if (fromDate != null) {
  //     page = 1;
  //     getOrderCompleted();
  //   }
  //   notifyListeners();
  // }





  RefreshController refreshCtlCancel = RefreshController(initialRefresh: false);
  ScrollController scrollCrlCancel = ScrollController();
  int pageCancel = 1;
  int perPageCancel = 10;
  bool isLastPageCancel = false;

  void onRefreshCancel() {
    pageCancel = 1;
    isLastPageCancel = false;
    getOrderCancel();
    refreshCtlCancel.refreshCompleted();
  }

  Future<void> getOrderCancel() async {
    try {
      final res = await orderRepo.getListOrders(
          appData.tokenLogin,
          pageCancel,
          perPageCancel,
          "cancelled"
      );
      if (res.status == true) {
        ordersCancel = res.data!;
      } else {
        ordersCancel = [];
      }
    } catch (e) {
      Logger.d('GET ordersCancel >>>', e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadMoreOrderCancel() async {
    try {
      if (scrollCrlCancel.position.pixels == scrollCrlCancel.position.maxScrollExtent) {
        if (!isLastPageCancel) {
          pageCancel++;
          final res = await orderRepo.getListOrders(
              appData.tokenLogin,
              pageCancel,
              perPageCancel,
              "cancelled"
          );
          if (res.status == true) {
            ordersCancel.addAll(res.data ?? []);
            isLastPageCancel = !(res.status ?? false) || (res.data?.isEmpty ?? true);
          } else {
            isLastPageCancel = true;
          }
        }
      }
    } catch (e) {
      Logger.d('LOAD MORE >>>', e);
    } finally {
      notifyListeners();
    }
  }


}
