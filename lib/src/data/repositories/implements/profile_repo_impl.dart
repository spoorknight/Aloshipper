import 'dart:convert';

import 'package:app_shipper/src/features/price_setting_ride_hailing/price_setting_dto.dart';
import 'package:app_shipper/src/models/list_review_shipper_model/list_review_shipper_model.dart';
import 'package:app_shipper/src/models/list_service_model.dart';
import 'package:app_shipper/src/models/list_service_new_model.dart';
import 'package:app_shipper/src/models/price_setting_ride_hailing_model/ride_hailing_setting_model.dart';
import 'package:app_shipper/src/models/user_active_info_model.dart';
import 'package:app_shipper/src/models/user_info/user_info_res.dart';
import 'package:app_shipper/src/models/vehicle_model/vehicle_model_by_brand.dart';
import 'package:app_shipper/src/models/vehicle_model/vehilce_brand_model.dart';
import 'package:dio/dio.dart';

import '../../../di/injection/injection.dart';
import '../../../models/bank_info.dart';
import '../../../models/bank_model.dart';
import '../../../models/list_address_model.dart/list_address_model.dart';
import '../../../models/nap_tien_model/nap_tien_model.dart';
import '../../../models/profile_model.dart';
import '../../../models/shared_models/base_model.dart';
import '../../../models/user_bank_account_model.dart';
import '../../data_sources/remote/profile_api.dart';
import '../profile_repository.dart';

class ProfileRepoImpl implements ProfileRepository {
  final ProfileApi profileApi;

  const ProfileRepoImpl({required this.profileApi});

  @override
  Future<ProfileModel> getProfileShopApi(
      String tokenlogin, String device_token) {
    return profileApi.getProfileShopApi(tokenlogin, device_token);
  }

  @override
  Future<ListAddressModel> getTinhTPList(
      String tokenlogin, String device_token) {
    return profileApi.getTinhTPList(tokenlogin, device_token);
  }

  @override
  Future<ListAddressModel> getQuanHuyenList(
      String tokenlogin, String device_token, String tinh_id) {
    return profileApi.getQuanHuyenList(tokenlogin, device_token, tinh_id);
  }

  @override
  Future<ListAddressModel> getPhuongXaList(
      String tokenlogin, String device_token, String quan_id) {
    return profileApi.getPhuongXaList(tokenlogin, device_token, quan_id);
  }

  @override
  Future<BaseModel> updateProfile(
    String tokenlogin,
    String device_token,
    String username,
    String fullname,
    String? avatar,
    String? password,
    String? password2,
    String phone_number,
    String email,
    String? address,
    String? country_id,
    String? state_id,
    String? city_id,
  ) {
    return profileApi.updateProfile(
      tokenlogin,
      device_token,
      username,
      fullname,
      avatar,
      password,
      password2,
      phone_number,
      email,
      address,
      country_id,
      state_id,
      city_id,
    );
  }

  @override
  Future<NapTienModel> napTien(
      String tokenlogin, String device_token, String amount) {
    return profileApi.napTien(tokenlogin, device_token, amount);
  }

  @override
  Future<BaseModel> rutTienChuyenKhoan(String tokenlogin, String device_token,
      String amount, String sotk, String tentk, String bank) {
    return profileApi.rutTienChuyenKhoan(
        tokenlogin, device_token, amount, sotk, tentk, bank);
  }

  @override
  Future<BaseModel> rutTienMat(String tokenlogin, String device_token,
      String id_daily, String amount, String password) {
    return profileApi.rutTienMat(
        tokenlogin, device_token, id_daily, amount, password);
  }

  @override
  Future<BaseModel> updatePhiGiaoHang(
      String tokenlogin, String device_token, String phigiaohang,String fee_per_km) {
    return profileApi.updatePhiGiaoHang(tokenlogin, device_token, phigiaohang,fee_per_km);
  }

  @override
  Future<BaseModel> updatePhiGoiXe(
      String tokenlogin, String device_token, String phigoixe) {
    return profileApi.updatePhiGoiXe(tokenlogin, device_token, phigoixe);
  }

  @override
  Future<ListReviewShipperModel> getListReviewShipper(
      String tokenlogin, String device_token, int page, int per_page) {
    return profileApi.getListReviewShipper(
        tokenlogin, device_token, page, per_page);
  }

  @override
  Future<ListServiceModel> getListServiceModel(
      String tokenlogin, String device_token) {
    return profileApi.getListServiceModel(tokenlogin, device_token);
  }

  @override
  Future<ListServiceNewModel> getListServiceNewModel(
      String tokenlogin) {
    return profileApi.getListServiceNewModel(tokenlogin);
  }

  @override
  Future<BaseModel> autoGiaHan(
      String tokenlogin, String device_token, int active) {
    return profileApi.autoGiaHan(tokenlogin, device_token, active);
  }

  @override
  Future<BaseModel> thanhToanGoiDichVu(
      String tokenlogin, String device_token, int plan_id) {
    return profileApi.thanhToanGoiDichVu(tokenlogin, device_token, plan_id);
  }

  @override
  Future<BaseModel> updateToaDo(
      String tokenlogin, double? latitude, double? longitude) {
    return profileApi.updateToaDo(tokenlogin, latitude, longitude);
  }

  @override
  Future<BaseModel> deleteAccount(String tokenlogin, String device_token) {
    return profileApi.deleteAccount(tokenlogin, device_token);
  }

  @override
  Future<BankInfo> getBankInfo() async {
    try {
      final res = await getIt<Dio>().get(
        'http://alotoday.vn/apiv3/getInfoPayment',
      );
      return BankInfo.fromJson(jsonDecode(res.data));
    } catch (e) {
      return BankInfo();
    }
  }

  @override
  Future<VehilceBrandResponse> getVehicleBrands() {
    return profileApi.getVehicleBrands();
  }

  @override
  Future<VehicleModelByBrand> getVehicleModelByBrand(String brand_id) {
    return profileApi.getVehicleModelByBrand(brand_id);
  }

  @override
  Future<BaseModel> updatePhiKmDauTien(
      String tokenlogin, String device_token, String phiKmDau) {
    return profileApi.updatePhiKmDauTien(tokenlogin, device_token, phiKmDau);
  }

  @override
  Future<UserInfoActiveModel> getActivityShipperInfo() {
    return profileApi.getUserInfoActive(appData.userId);
  }

  @override
  Future<UserInfoRes> getUserInfo() {
    return profileApi.getUserInfo(appData.tokenLogin);
  }

  @override
  Future<BaseModel> updateStatusOrderShipper(
      String tokenlogin, String batGoiXe, String batNhanHang) {
    return profileApi.updateStatusOrderShipper(
        tokenlogin, batGoiXe, batNhanHang);
  }

  @override
  Future<UserBankAccountModel> getUserBanksInfo(String token) {
    return profileApi.getUserBanksInfo(token);
  }

  @override
  Future<RideHailingSettingModel> getRideHailingSetting(String token) {
    return profileApi.getRideHailingSetting(token);
  }

  @override
  Future<ResponseBankInfoModel> getBanks() {
    return profileApi.getBanks();
  }

  @override
  Future<BaseModel> createOrUpdate(String token, String bank_id,
      String user_bank_name, String user_bank_number) {
    return profileApi.createOrUpdate(
        token, bank_id, user_bank_name, user_bank_number);
  }

  @override
  Future<BaseModel> updatePriceRideHailing(String token,String setting) {
    return profileApi.updatePriceRideHailing(token,setting);
  }

  @override
  Future<BaseModel> shareLinkStore(String tokenlogin, String reward_recipient_id, String mission_id) {
    return profileApi.shareLinkStore(tokenlogin, reward_recipient_id, mission_id);
  }
}
