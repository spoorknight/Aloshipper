import 'package:app_shipper/src/models/list_review_shipper_model/list_review_shipper_model.dart';
import 'package:app_shipper/src/models/list_service_model.dart';
import 'package:app_shipper/src/models/price_setting_ride_hailing_model/ride_hailing_setting_model.dart';
import 'package:app_shipper/src/models/user_active_info_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../models/bank_model.dart';
import '../../../models/list_address_model.dart/list_address_model.dart';
import '../../../models/nap_tien_model/nap_tien_model.dart';
import '../../../models/profile_model.dart';
import '../../../models/shared_models/base_model.dart';
import '../../../models/user_bank_account_model.dart';
import '../../../network/api_path.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String baseUrl}) = _ProfileApi;

  @POST(ApiPath.getProfileShopApi)
  @MultiPart()
  Future<ProfileModel> getProfileShopApi(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
  );

  @GET(ApiPath.getUserInfoActive)
  Future<UserInfoActiveModel> getUserInfoActive(
    @Query('shipper_id') String shipperId,
  );

  @POST(ApiPath.updateStatusOrderShipper)
  @MultiPart()
  Future<BaseModel> updateStatusOrderShipper(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'bat_goi_xe') String batGoiXe,
    @Part(name: 'bat_nhan_hang') String batNhanHang,
  );

  @POST(ApiPath.getTinhTPList)
  @MultiPart()
  Future<ListAddressModel> getTinhTPList(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
  );

  @POST(ApiPath.getQuanHuyenList)
  @MultiPart()
  Future<ListAddressModel> getQuanHuyenList(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'tinh_id') String tinh_id,
  );

  @POST(ApiPath.getPhuongXaList)
  @MultiPart()
  Future<ListAddressModel> getPhuongXaList(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'quan_id') String quan_id,
  );

  @POST(ApiPath.updateProfileShipper)
  @MultiPart()
  Future<BaseModel> updateProfile(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'username') String username,
    @Part(name: 'fullname') String fullname,
    @Part(name: 'avatar') String? avatar,
    @Part(name: 'password') String? password,
    @Part(name: 'password2') String? password2,
    @Part(name: 'phone_number') String phone_number,
    @Part(name: 'email') String email,
    @Part(name: 'address') String? address,
    @Part(name: 'country_id') String? country_id,
    @Part(name: 'state_id') String? state_id,
    @Part(name: 'city_id') String? city_id,
  );

  @POST(ApiPath.rutTienChuyenKhoanApi)
  @MultiPart()
  Future<BaseModel> rutTienChuyenKhoan(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'amount') String amount,
    @Part(name: 'sotk') String sotk,
    @Part(name: 'tentk') String tentk,
    @Part(name: 'bank') String bank,
  );

  @POST(ApiPath.rutTienMatDaiLyAPI)
  @MultiPart()
  Future<BaseModel> rutTienMat(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'id_daily') String id_daily,
    @Part(name: 'amount') String amount,
    @Part(name: 'password') String password,
  );

  @POST(ApiPath.naptien)
  @MultiPart()
  Future<NapTienModel> napTien(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'amount') String amount,
  );

  @POST(ApiPath.updateFeeShipper)
  @MultiPart()
  Future<BaseModel> updatePhiGiaoHang(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'phigiaohang') String phigiaohang,
  );

  @POST(ApiPath.updateFeeShipper)
  @MultiPart()
  Future<BaseModel> updatePhiGoiXe(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'phigoixe') String phigoixe,
  );

  @POST(ApiPath.updateFeeShipper)
  @MultiPart()
  Future<BaseModel> updatePhiKmDauTien(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'fee_per_km') String phiKmDau,
  );

  @POST(ApiPath.getListReviewShipper)
  @MultiPart()
  Future<ListReviewShipperModel> getListReviewShipper(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'page') int page,
    @Part(name: 'per_page') int per_page,
  );

  @POST(ApiPath.getGoiDichVuShipper)
  @MultiPart()
  Future<ListServiceModel> getListServiceModel(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
  );

  @POST(ApiPath.autoGiaHan)
  @MultiPart()
  Future<BaseModel> autoGiaHan(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'active') int active,
  );

  @POST(ApiPath.thanhToanGoiDichVu)
  @MultiPart()
  Future<BaseModel> thanhToanGoiDichVu(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
    @Part(name: 'plan_id') int plan_id,
  );

  @POST(ApiPath.updateLatLng)
  @MultiPart()
  Future<BaseModel> updateToaDo(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'latitude') double? latitude,
    @Part(name: 'longitude') double? longitude,
  );

  @POST(ApiPath.huyTaiKhoan)
  @MultiPart()
  Future<BaseModel> deleteAccount(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'device_token') String device_token,
  );

  @POST(ApiPath.getUserBanksInfo)
  @MultiPart()
  Future<UserBankAccountModel> getUserBanksInfo(
    @Part(name: 'token') String token,
  );

  @POST(ApiPath.getRideHailingSetting)
  @MultiPart()
  Future<RideHailingSettingModel> getRideHailingSetting(
      @Part(name: 'token') String token,);

  @GET(ApiPath.getBanks)
  Future<ResponseBankInfoModel> getBanks();

  @POST(ApiPath.createOrUpdate)
  @MultiPart()
  Future<BaseModel> createOrUpdate(
    @Part(name: 'token') String token,
    @Part(name: 'bank_id') String bank_id,
    @Part(name: 'user_bank_name') String user_bank_name,
    @Part(name: 'user_bank_number') String user_bank_number,
  );

  @POST(ApiPath.updateRideHailingSetting)
  @MultiPart()
  Future<BaseModel> updatePriceRideHailing(
    @Part(name: 'token') String token,
    @Part(name: 'settings') String setting,
  );

  @POST(ApiPath.giftCreate)
  @MultiPart()
  Future<BaseModel> shareLinkStore(
    @Part(name: 'tokenlogin') String tokenlogin,
    @Part(name: 'reward_recipient_id') String reward_recipient_id,
    @Part(name: 'mission_id') String mission_id,
  );
}
