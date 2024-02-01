import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/collaborate_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/collaborate_info_model/collaborate_info_model.dart';
import '../../utils/helpers/logger.dart';

class CollaborateViewModel extends BaseViewModel {
  final CollaborateRepository collabRepo;

  CollaborateViewModel({required this.collabRepo}) : super() {
    getCollbabInfo();
  }

  CollaborateInfoModel? collaborateInfo;

  RefreshController refreshCtl = RefreshController();

  Future<void> getCollbabInfo() async {
    setLoading = true;
    try {
      final res = await collabRepo.getCollbabInfo(
        appData.tokenLogin,
        appData.firebaseToken,
      );
      if (res.status == true) {
        collaborateInfo = res;
      }
    } catch (e) {
      Logger.d('GET COLLBAB INFO >>>', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  void onRefresh() {
    getCollbabInfo();
    refreshCtl.refreshCompleted();
  }
}
