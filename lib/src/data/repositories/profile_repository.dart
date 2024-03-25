import 'package:app_shipper/src/features/price_setting_ride_hailing/price_setting_dto.dart';
import 'package:app_shipper/src/models/list_review_shipper_model/list_review_shipper_model.dart';
import 'package:app_shipper/src/models/list_service_new_model.dart';
import 'package:app_shipper/src/models/price_setting_ride_hailing_model/ride_hailing_setting_model.dart';
import 'package:app_shipper/src/models/user_active_info_model.dart';
import 'package:app_shipper/src/models/user_info/user_info_res.dart';
import 'package:app_shipper/src/models/vehicle_model/vehicle_model_by_brand.dart';
import 'package:app_shipper/src/models/vehicle_model/vehilce_brand_model.dart';

import '../../models/bank_info.dart';
import '../../models/bank_model.dart';
import '../../models/list_address_model.dart/list_address_model.dart';
import '../../models/list_service_model.dart';
import '../../models/nap_tien_model/nap_tien_model.dart';
import '../../models/profile_model.dart';
import '../../models/shared_models/base_model.dart';
import '../../models/user_bank_account_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfileShopApi(String tokenlogin, String device_token);

  Future<BaseModel> shareLinkStore(
      String tokenlogin, String reward_recipient_id, String mission_id);

  Future<BaseModel> updateStatusOrderShipper(String tokenlogin, String batGoiXe, String batNhanHang);

  Future<UserInfoActiveModel> getActivityShipperInfo();

  Future<UserBankAccountModel> getUserBanksInfo(String token);

  Future<UserInfoRes> getUserInfo();

  Future<RideHailingSettingModel> getRideHailingSetting(String token);
  Future<BaseModel> createOrUpdate(String token, String bank_id,
      String user_bank_name, String user_bank_number);

  Future<ResponseBankInfoModel> getBanks();

  Future<VehilceBrandResponse> getVehicleBrands();

  Future<VehicleModelByBrand> getVehicleModelByBrand(String brand_id);

  Future<BaseModel> updatePriceRideHailing(String token,String setting);

  Future<ListAddressModel> getTinhTPList(String tokenlogin, String device_token);

  Future<ListAddressModel> getQuanHuyenList(String tokenlogin, String device_token, String tinh_id);

  Future<ListAddressModel> getPhuongXaList(String tokenlogin, String device_token, String quan_id);

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
  );

  Future<NapTienModel> napTien(String tokenlogin, String device_token, String amount);

  Future<BaseModel> rutTienChuyenKhoan(
    String tokenlogin,
    String device_token,
    String amount,
    String sotk,
    String tentk,
    String bank,
  );

  Future<BaseModel> rutTienMat(
    String tokenlogin,
    String device_token,
    String id_daily,
    String amount,
    String password,
  );

  Future<BaseModel> updatePhiGiaoHang(
    String tokenlogin,
    String device_token,
    String phigiaohang,
    String fee_per_km,
  );
  Future<BaseModel> updatePhiGoiXe(
    String tokenlogin,
    String device_token,
    String phigoixe,
  );
  Future<BaseModel> updatePhiKmDauTien(
    String tokenlogin,
    String device_token,
    String phiKmDau,
  );

  Future<ListReviewShipperModel> getListReviewShipper(
    String tokenlogin,
    String device_token,
    int page,
    int per_page,
  );

  Future<ListServiceModel> getListServiceModel(
    String tokenlogin,
    String device_token,
  );

  Future<ListServiceNewModel> getListServiceNewModel(
    String tokenlogin,
  );

  Future<BaseModel> autoGiaHan(
    String tokenlogin,
    String device_token,
    int active,
  );

  Future<BaseModel> thanhToanGoiDichVu(
    String tokenlogin,
    String device_token,
    int plan_id,
  );

  Future<BaseModel> updateToaDo(
    String tokenlogin,
    double? latitude,
    double? longitude,
  );

  Future<BaseModel> deleteAccount(
    String tokenlogin,
    String device_token,
  );
  Future<BankInfo> getBankInfo();

}
