import '../../models/event/customer_point_info_model.dart';
import '../../models/event/exchange_point_model.dart';
import '../../models/event/history_mission_model.dart';
import '../../models/event/mission_model.dart';
import '../../models/event/refer_friend_model.dart';
import '../../models/event/store_for_share_model.dart';
import '../../models/event/voucher_transfer_model.dart';
import '../../models/shared_models/base_model.dart';

abstract class EventRepository {
  ///lấy thông tin số điểm hiện tại, số điểm đã đổi…
  Future<CustomerPointInfoResponse> giftPointsInfo(String tokenlogin);

  ///lấy thông tin danh sách số điểm đã quy đổi sang tiền
  Future<ExchangePointResponse> getPointsExchangeHistories(
      String tokenlogin, int page);

  ///user chọn tiền và đổi điểm
  Future<BaseModel> giftExchangePointsToMoney(
      String tokenlogin, double value, String type);

  ///lấy danh sách các nhiệm vụ
  Future<MissionResponse> giftGetDailyMissions(
      String tokenlogin, String appName);

  ///Lấy danh sách lịch sử đã thực hiện nhiệm vụ
  Future<HistoryMissionResponse> giftGetMissionHistories(
      String tokenlogin, int page);

  ///Lấy danh sách lịch sử đã thực hiện nhiệm vụ
  Future<BaseModel> doneAdvertising(
      String tokenlogin, String adId, String adType, String giftType);

  ///Lấy danh sách tiến độ của bạn bè
  Future<ReferFriendResponse> getReferFriends(String tokenlogin);

  ///Thu hoạch
  Future<BaseModel> addGiftForReferFriendMission(String tokenlogin);

  ///Kiểm tra có được xem quảng cáo không
  Future<BaseModel> checkValidAdViews(String tokenlogin);

  ///Đổi voucher
  Future<BaseModel> exchangePointsToGift(
      String tokenlogin, String value, String type, String voucherId);

  ///danh sách vouchers để đổi
  Future<VoucherTransfersResponse> getPointRedemptionVouchers(
      String tokenlogin);

  ///Danh sách cửa hàng để share
  Future<StoreForShareResponse> getStoresPurchasedSharePackage(
      String tokenlogin, int page, double myLatitude, double myLongtitude);

  ///Lấy danh sách lịch sử đã thực hiện nhiệm vụ
  Future<BaseModel> createCheckIn(String tokenlogin, String rewardRecipientId,
      String missionId, String giftType,
      {String? adsUserId});
}
