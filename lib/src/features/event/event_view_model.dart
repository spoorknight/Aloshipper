import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/event_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/event/customer_point_info_model.dart';
import '../../models/event/exchange_point_model.dart';
import '../../models/event/history_mission_model.dart';
import '../../models/event/mission_model.dart';
import '../../models/event/refer_friend_model.dart';
import '../../models/event/store_for_share_model.dart';
import '../../models/event/voucher_transfer_model.dart';
import '../../shared/show_toast.dart';
import '../../utils/app_enum.dart';
import '../../utils/helpers/logger.dart';

class EventViewModel extends BaseViewModel {
  final EventRepository eventRepository;

  EventViewModel({required this.eventRepository}) : super() {
    initData();
    getLinkGioiThieu();
    scrollStoreCtl.addListener(loadMoreStore);
  }

  final RefreshController refreshRewardCtl =
      RefreshController(initialRefresh: false);
  CustomerPointInfoModel? customerPointInfoModel;
  late MissionResponse _missionResponse;
  List<MissionModel> listMissions = [];
  String missionTitle = '';
  String shareTitle = '';
  List<HistoryMissionModel> historiesMission = [];
  List<ExchangePointModel> historiesExchangePoint = [];
  MissionModel? missionShare;
  MissionModel? shareStore;

  int currentHistoriesMissionPage = 1;
  int currentExchangePointPage = 1;

  bool customerPointInfoLoading = false;
  bool customerMissionLoading = false;

  bool historiesMissionCanLoadMore = true;
  bool historiesExchangePointCanLoadMore = true;

  RefreshController refreshCtlRedeem = RefreshController();
  RefreshController refreshCtlHistoriesMission = RefreshController();

  String linkMoiDangKyTaiKhoan = '';
  String codeShare = '';

  bool doneAdVideo = false;

  // RewardedInterstitialAd? rewardedInterstitialAd;
  bool isAddGiftForReferFriendMission = false;

  RefreshController refreshCtl = RefreshController();
  ScrollController scrollCrl = ScrollController();

  List<ReferFriendModel> lstProgressOfFriends = [];

  List<StoreForShareModel> listStoresForShare = [];
  final ScrollController scrollStoreCtl = ScrollController();
  final RefreshController refreshListStoreCtl = RefreshController();
  bool isLastPageStore = false;
  int currentStorePage = 1;

  GiftType giftType = GiftType.day;

  List<VoucherTransferModel> lstVouchersTransfer = [];

  Future<void> getProgressOfFriends() async {
    try {
      notifyListeners();
      final res = await eventRepository.getReferFriends(appData.tokenLogin);
      if (res.status == true) {
        lstProgressOfFriends = res.data ?? [];
      } else {}
    } catch (e) {
      Logger.d('getUserPointInfo', e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadMoreStore() async {
    if (scrollStoreCtl.position.pixels ==
            scrollStoreCtl.position.maxScrollExtent &&
        !isLastPageStore &&
        !isLoading) {
      currentStorePage += 1;
      notifyListeners();
      await getStoresPurchasedSharePackage();
      refreshListStoreCtl.loadComplete();
    }
  }

  Future<void> onRefreshStore() async {
    currentStorePage = 1;
    isLastPageStore = false;
    notifyListeners();
    await getStoresPurchasedSharePackage();
    refreshListStoreCtl.refreshCompleted();
  }

  Future<void> getStoresPurchasedSharePackage() async {
    try {
      if (currentStorePage == 1) {
        setLoading = true;
      }
      final res = await eventRepository.getStoresPurchasedSharePackage(
        appData.tokenLogin,
        currentStorePage,
        appData.myCurrentAddress?.latitude ?? 0,
        appData.myCurrentAddress?.longitude ?? 0,
      );
      if (res.status == true) {
        final data = res.list ?? [];
        isLastPageStore = res.isLastPage;

        if (currentStorePage == 1) {
          listStoresForShare = data;
        } else {
          listStoresForShare.addAll(data);
        }
      } else {}
    } catch (e) {
      Logger.d('getUserPointInfo', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRewardedAd() async {
    doneAdVideo = false;
    RewardedAd.load(
      adUnitId: _missionResponse.getInitAdsKey ?? '',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) async {
              ad.dispose();
              if (doneAdVideo) {
                await doneAdvertising();
              }
            },
          );
          ad.show(
            onUserEarnedReward:
                (AdWithoutView adWithoutView, RewardItem rewardItem) async {
              doneAdVideo = true;
              EasyLoading.dismiss();
            },
          );
        },
        onAdFailedToLoad: (err) {
          ShowToast.error(err.message);
          EasyLoading.dismiss();
        },
      ),
    );
  }

  void initData() {
    try {
      Future.wait([
        getUserPointInfo(),
        getUserMissions(),
      ]);
    } catch (e) {
      Logger.d('initData', e);
    } finally {
      refreshRewardCtl.refreshCompleted();
    }
  }

  Future<bool> exchangePointsToMoney(
      {required int value, ExchangeType type = ExchangeType.money}) async {
    try {
      EasyLoading.show();
      final res = await eventRepository.giftExchangePointsToMoney(
        appData.tokenLogin,
        value.toDouble(),
        type.value,
      );
      EasyLoading.dismiss();
      if (res.status == true) {
        return true;
      } else {
        EasyLoading.showError(res.mess ?? 'Có lỗi xảy ra');
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Có lỗi xảy ra');
      return false;
    }
  }

  Future<void> getUserPointInfo() async {
    try {
      customerPointInfoLoading = true;
      notifyListeners();
      final res = await eventRepository.giftPointsInfo(appData.tokenLogin);
      if (res.status == true) {
        customerPointInfoModel = res.data;
      }
    } catch (e) {
      Logger.d('getUserPointInfo', e);
    } finally {
      customerPointInfoLoading = false;
      notifyListeners();
    }
  }

  Future<void> doneAdvertising() async {
    try {
      EasyLoading.show();
      final res = await eventRepository.doneAdvertising(
          appData.tokenLogin, '', AdvertisingType.admob.value, giftType.value);
      if (res.status == true) {
        ShowToast.success(res.mess ?? 'Thành công');
        initData();
      } else {
        ShowToast.error(res.mess ?? 'Không thành công');
      }
    } catch (e) {
      Logger.d('getUserPointInfo', e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getUserMissions() async {
    try {
      customerMissionLoading = true;
      notifyListeners();
      final res = await eventRepository.giftGetDailyMissions(
          appData.tokenLogin, AppNameEnum.aloshipper.value);
      if (res.status == true) {
        _missionResponse = res;
        listMissions = (res.data ?? [])
            .where((element) => element.isDisable != true)
            .toList();
        missionTitle = res.missionTitle ?? '';
        shareTitle = res.shareTitle ?? '';

        if (missionShare != null) {
          missionShare =
              res.data?.firstWhere((element) => element.id == missionShare?.id);
        }
        shareStore = res.data?.firstWhere(
            (element) => element.getMissionType == MissionType.share);
      }
    } catch (e) {
      Logger.d('getUserMissions', e);
    } finally {
      customerMissionLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMissionHistories() async {
    try {
      EasyLoading.show();
      final res = await eventRepository.giftGetMissionHistories(
          appData.tokenLogin, currentHistoriesMissionPage);
      if (res.status == true) {
        final resData = res.data ?? [];
        if (currentHistoriesMissionPage == 1) {
          historiesMission = resData;
        } else {
          historiesMission.addAll(resData);
        }
        historiesMissionCanLoadMore =
            resData.length >= res.getTotalItemInPerPage;
      }
    } catch (e) {
      Logger.d('getUserMissions', e);
    } finally {
      refreshCtlHistoriesMission.refreshCompleted();
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  onRefreshMissionHistories() {
    currentHistoriesMissionPage = 1;
    historiesMissionCanLoadMore = true;
    getMissionHistories();
  }

  onLoadMoreMissionHistories() {
    currentHistoriesMissionPage += 1;
    getMissionHistories();
  }

  Future<void> getPointsExchangeHistories() async {
    try {
      EasyLoading.show();
      final res = await eventRepository.getPointsExchangeHistories(
          appData.tokenLogin, currentExchangePointPage);
      if (res.status == true) {
        final resData = res.data ?? [];
        if (currentExchangePointPage == 1) {
          historiesExchangePoint = resData;
        } else {
          historiesExchangePoint.addAll(resData);
        }
        historiesExchangePointCanLoadMore =
            resData.length >= res.getTotalItemInPerPage;
      }
    } catch (e) {
      Logger.d('getUserMissions', e);
    } finally {
      refreshCtlRedeem.refreshCompleted();
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  onRefreshPointsExchangeHistories() {
    currentExchangePointPage = 1;
    historiesExchangePointCanLoadMore = true;
    getPointsExchangeHistories();
  }

  onLoadMorePointsExchangeHistories() {
    currentExchangePointPage += 1;
    getPointsExchangeHistories();
  }

  Future<void> createCheckIn(String missionId, {String? adsUserId}) async {
    try {
      EasyLoading.show();
      final res = await eventRepository.createCheckIn(
        appData.tokenLogin,
        appData.userId,
        missionId,
        giftType.value,
        adsUserId: adsUserId,
      );
      if (res.status == true) {
        ShowToast.success(res.mess ?? 'Thành công');
        initData();
      } else {
        ShowToast.error(res.mess ?? 'Thất bại');
      }
    } catch (e) {
      Logger.d('createCheckIn', e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getLinkGioiThieu() async {
    String userId = appData.userId;
    if (userId.isNotEmpty) {
      codeShare = userId;
      final res =
          await getShortLink("https://alotoday.vn/register?ref_id=$userId");
      if (res != null) {
        linkMoiDangKyTaiKhoan = res;
        notifyListeners();
      }
    }
  }

  Future<void> addGiftForReferFriendMission() async {
    try {
      EasyLoading.show();
      final res = await eventRepository
          .addGiftForReferFriendMission(appData.tokenLogin);
      if (res.status == true) {
        isAddGiftForReferFriendMission = true;
        ShowToast.success(res.mess ?? 'Thành công');
        initData();
      } else {
        ShowToast.error(res.mess ?? 'Thất bại');
      }
    } catch (e) {
      Logger.d('createCheckIn', e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> shareStoreForMission(String subdomain, String? adsUserId) async {
    try {
      EasyLoading.show();
      // final res = 'await genLinkStoreShare()';
      final res = await genLinkStoreShare(subdomain);
      if (res != null && shareStore != null) {
        await Clipboard.setData(
          ClipboardData(text: res),
        );

        ShareResult shareResult = await Share.shareWithResult(res);

        if (shareResult.status == ShareResultStatus.success &&
            (shareResult.raw.toLowerCase().contains('facebook') ||
                shareResult.raw.toLowerCase().contains('zalo') ||
                shareResult.raw.toLowerCase().contains('zing'))) {
          await createCheckIn(shareStore!.id ?? '1', adsUserId: adsUserId);
        }
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<bool> checkValidAdViews() async {
    try {
      final res = await eventRepository.checkValidAdViews(appData.tokenLogin);
      if (res.status == true) {
        return true;
      } else {
        ShowToast.error(res.mess ?? '');
        EasyLoading.dismiss();
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<void> exchangePointsToGift(
      String value, String type, String voucherId) async {
    try {
      EasyLoading.show();
      final res = await eventRepository.exchangePointsToGift(
          appData.tokenLogin, value, type, voucherId);
      if (res.status == true) {
        initData();
        ShowToast.success(res.mess);
      } else {
        ShowToast.error(res.mess ?? 'Có lỗi xảy ra');
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getPointRedemptionVouchers() async {
    try {
      EasyLoading.show();
      final res =
          await eventRepository.getPointRedemptionVouchers(appData.tokenLogin);
      if (res.status == true) {
        lstVouchersTransfer = res.data ?? [];
      } else {}
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<String?> genLinkStoreShare(String subdomain) async {
    try {
      final res = await getShortLink("https://alotoday.vn/shop/$subdomain");
      if (res != null) {
        return res;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
