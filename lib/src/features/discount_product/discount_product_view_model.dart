import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/collaborate_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/list_discount_product_model/discount_product_model.dart';
import '../../shared/show_toast.dart';
import '../../utils/helpers/logger.dart';

class DiscountProductViewModel extends BaseViewModel {
  final CollaborateRepository collabRepo;

  DiscountProductViewModel({required this.collabRepo}) : super() {
    getListDiscountProduct();
    scrollCrl.addListener(loadMore);
  }

  List<DiscountProductModel> discountProducts = [];

  RefreshController refreshCtl = RefreshController();
  ScrollController scrollCrl = ScrollController();

  void onRefresh() {
    page = 1;
    isLastPage = false;
    getListDiscountProduct();
    refreshCtl.refreshCompleted();
  }

  Future<void> getListDiscountProduct() async {
    setLoading = true;
    try {
      final res = await collabRepo.getListDiscountProduct(
        appData.tokenLogin,
        appData.firebaseToken,
        page,
        perPage,
      );
      if (res.status == true) {
        discountProducts = res.list ?? [];
      }
    } catch (e) {
      Logger.d('GET LIST DISCOUNT PRODUCT >>>', e);
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
          final res = await collabRepo.getListDiscountProduct(
            appData.tokenLogin,
            appData.firebaseToken,
            page,
            perPage,
          );
          if (res.status == true) {
            discountProducts.addAll(res.list ?? []);
            isLastPage = !(res.status ?? false) || (res.list?.isEmpty ?? true);
          } else {
            isLastPage = true;
          }
          notifyListeners();
        }
      }
    } catch (e) {
      Logger.d('LOAD MORE DISCOUNT PRODUCT >>>', e);
    }
  }

  void shareShortLink(String? url) async {
    EasyLoading.show();
    try {
      final res = await collabRepo.getShortLink(url);
      if (res?.isNotEmpty == true) {
        Share.share(res!);
      } else {
        ShowToast.error('Có lỗi xảy ra');
      }
    } catch (e) {
      Logger.d('SHARE SHORT LINK >>>', e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
