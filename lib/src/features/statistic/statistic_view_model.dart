import 'package:app_shipper/src/base/base_view_model.dart';
import 'package:app_shipper/src/data/repositories/order_repository.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/list_order_model/order.dart';
import '../../utils/helpers/logger.dart';

class StatisticViewModel extends BaseViewModel {
  final OrderRepository orderRepo;

  StatisticViewModel({required this.orderRepo}) : super() {
    getStatistic();
    scrollCrl.addListener(loadMore);
  }

  final fromDateEC = TextEditingController();
  final toDateEC = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  List<Order> orders = [];

  RefreshController refreshCtl = RefreshController(initialRefresh: false);
  ScrollController scrollCrl = ScrollController();

  void onRefresh() {
    fromDate = null;
    toDate = null;
    fromDateEC.clear();
    toDateEC.clear();
    page = 1;
    isLastPage = false;
    getStatistic();
    refreshCtl.refreshCompleted();
  }

  Future<void> getStatistic() async {
    setLoading = true;
    try {
      final res = await orderRepo.getListCompletedOrdersShipper(
        appData.tokenLogin,
        appData.firebaseToken,
        fromDateEC.text,
        toDateEC.text,
        page,
        perPage,
      );
      if (res.status == true) {
        orders = res.list!;
      } else {
        orders = [];
      }
    } catch (e) {
      Logger.d('GET STATISTIC >>>', e);
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
          final res = await orderRepo.getListCompletedOrdersShipper(
            appData.tokenLogin,
            appData.firebaseToken,
            fromDateEC.text,
            toDateEC.text,
            page,
            perPage,
          );
          if (res.status == true) {
            orders.addAll(res.list ?? []);
            isLastPage = !(res.status ?? false) || (res.list?.isEmpty ?? true);
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

  void selectFromDate(DateTime newDate) {
    fromDate = newDate;
    fromDateEC.text = DateFormat('dd/MM/yyyy').format(newDate);
    if (toDate != null) {
      page = 1;
      getStatistic();
    }
    notifyListeners();
  }

  void selectToDate(DateTime newDate) {
    toDate = newDate;
    toDateEC.text = DateFormat('dd/MM/yyyy').format(newDate);
    if (fromDate != null) {
      page = 1;
      getStatistic();
    }
    notifyListeners();
  }
}
