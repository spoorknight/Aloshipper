
import '../../../models/event/customer_point_info_model.dart';
import '../../../models/event/exchange_point_model.dart';
import '../../../models/event/history_mission_model.dart';
import '../../../models/event/mission_model.dart';
import '../../../models/event/refer_friend_model.dart';
import '../../../models/event/store_for_share_model.dart';
import '../../../models/event/voucher_transfer_model.dart';
import '../../../models/shared_models/base_model.dart';
import '../../data_sources/remote/event_api.dart';
import '../event_repository.dart';

class EventRepoImpl implements EventRepository {
  final EventApi eventApi;

  const EventRepoImpl({required this.eventApi});

  @override
  Future<ExchangePointResponse> getPointsExchangeHistories(
      String tokenlogin, int page) {
    return eventApi.getPointsExchangeHistories(tokenlogin, page);
  }

  @override
  Future<BaseModel> giftExchangePointsToMoney(String tokenlogin, double value, String type) {
    return eventApi.giftExchangePointsToMoney(tokenlogin, value, type);
  }

  @override
  Future<MissionResponse> giftGetDailyMissions(String tokenlogin, String appName) {
    return eventApi.giftGetDailyMissions(tokenlogin, appName);
  }

  @override
  Future<HistoryMissionResponse> giftGetMissionHistories(
      String tokenlogin, int page) {
    return eventApi.giftGetMissionHistories(tokenlogin, page);
  }

  @override
  Future<CustomerPointInfoResponse> giftPointsInfo(String tokenlogin) {
    return eventApi.giftPointsInfo(tokenlogin);
  }

  @override
  Future<BaseModel> createCheckIn(String tokenlogin, String rewardRecipientId,
      String missionId, String giftType, {String? adsUserId}) {
    return eventApi.createCheckIn(
        tokenlogin, rewardRecipientId, missionId, giftType, adsUserId);
  }

  @override
  Future<BaseModel> doneAdvertising(
      String tokenlogin, String adId, String adType, String giftType) {
    return eventApi.doneAdvertising(tokenlogin, adId, adType, giftType);
  }

  @override
  Future<ReferFriendResponse> getReferFriends(String tokenlogin) {
    return eventApi.getReferFriends(tokenlogin);
  }

  @override
  Future<BaseModel> addGiftForReferFriendMission(String tokenlogin) {
    return eventApi.addGiftForReferFriendMission(tokenlogin);
  }

  @override
  Future<StoreForShareResponse> getStoresPurchasedSharePackage(
      String tokenlogin, int page, double myLatitude, double myLongtitude) {
    return eventApi.getStoresPurchasedSharePackage(
        tokenlogin, page, myLatitude, myLongtitude);
  }

  @override
  Future<BaseModel> checkValidAdViews(String tokenlogin) {
    return eventApi.checkValidAdViews(tokenlogin);
  }

  @override
  Future<BaseModel> exchangePointsToGift(String tokenlogin, String value, String type, String voucherId) {
    return eventApi.exchangePointsToGift(tokenlogin, value, type, voucherId);
  }

  @override
  Future<VoucherTransfersResponse> getPointRedemptionVouchers(String tokenlogin) {
    return eventApi.getPointRedemptionVouchers(tokenlogin);
  }
}
