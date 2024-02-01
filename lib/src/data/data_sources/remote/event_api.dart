import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../models/event/customer_point_info_model.dart';
import '../../../models/event/exchange_point_model.dart';
import '../../../models/event/history_mission_model.dart';
import '../../../models/event/mission_model.dart';
import '../../../models/event/refer_friend_model.dart';
import '../../../models/event/store_for_share_model.dart';
import '../../../models/event/voucher_transfer_model.dart';
import '../../../models/shared_models/base_model.dart';
import '../../../network/api_path.dart';

part 'event_api.g.dart';

@RestApi()
abstract class EventApi {
  factory EventApi(Dio dio, {String baseUrl}) = _EventApi;

  @POST(ApiPath.getReferFriends)
  @MultiPart()
  Future<ReferFriendResponse> getReferFriends(
    @Part(name: 'tokenlogin') String tokenlogin,
  );

  @POST(ApiPath.getStoresPurchasedSharePackage)
  @MultiPart()
  Future<StoreForShareResponse> getStoresPurchasedSharePackage(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'page') int page,
    @Part(name: 'my_latitude') double myLatitude,
    @Part(name: 'my_longtitude') double myLongtitude,
  );

  @POST(ApiPath.addGiftForReferFriendMission)
  @MultiPart()
  Future<BaseModel> addGiftForReferFriendMission(
    @Part(name: 'tokenlogin') String tokenlogin,
  );

  @POST(ApiPath.checkValidAdViews)
  @MultiPart()
  Future<BaseModel> checkValidAdViews(
    @Part(name: 'tokenlogin') String tokenlogin,
  );

  @POST(ApiPath.exchangePointsToGift)
  @MultiPart()
  Future<BaseModel> exchangePointsToGift(
      @Part(name: 'tokenlogin') String tokenlogin,
      @Part(name: 'value') String valueTransfer,
      @Part(name: 'type') String type,
      @Part(name: 'voucher_id') String voucherId);

  @POST(ApiPath.getAlotodayVouchers)
  @MultiPart()
  Future<VoucherTransfersResponse> getPointRedemptionVouchers(
    @Part(name: 'tokenlogin') String tokenlogin,
  );

  @POST(ApiPath.giftGetPointsExchangeHistories)
  @MultiPart()
  Future<ExchangePointResponse> getPointsExchangeHistories(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'page') int page,
  );

  @POST(ApiPath.exchangePointsToMoneyOrDay)
  @MultiPart()
  Future<BaseModel> giftExchangePointsToMoney(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'value') double valueExchange,
    @Part(name: 'type') String type,
  );

  @POST(ApiPath.giftGetDailyMissions)
  @MultiPart()
  Future<MissionResponse> giftGetDailyMissions(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'app_name') String appName,
  );

  @POST(ApiPath.giftGetMissionHistories)
  @MultiPart()
  Future<HistoryMissionResponse> giftGetMissionHistories(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'page') int page,
  );

  @POST(ApiPath.giftPointsInfo)
  @MultiPart()
  Future<CustomerPointInfoResponse> giftPointsInfo(
    @Part(name: 'tokenlogin') String tokenlogin,
  );

  @POST(ApiPath.giftCreate)
  @MultiPart()
  Future<BaseModel> createCheckIn(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'reward_recipient_id') String rewardRecipientId,
    @Part(name: 'mission_id') String missionId,
    @Part(name: 'gift_type') String giftType,
    @Part(name: 'ads_user_id') String? adsUserId,
  );

  @POST(ApiPath.adCreate)
  @MultiPart()
  Future<BaseModel> doneAdvertising(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'ad_id') String adId,
    @Part(name: 'ad_type') String adType,
    @Part(name: 'gift_type') String giftType,
  );
}
