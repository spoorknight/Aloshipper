/// status : true
/// user_info : {"id":"1198","first_name":"Nguyễn hoàng nam","phone_number":"03524031401","email":"nctri01111@gmail.com","address":"aaaaaaaaaa","province_id":"75","district_id":"742","ward_id":"26494","loaixe":"1","sochongoi":"0","biensoxe":"60SHJS-DF","vehicle_model_id":"1","vehicle_brand_id":"1","vehicle_year":"2021","province_name":"Đồng Nai","district_name":"Huyện Nhơn Trạch","ward_name":"Xã Long Thọ","vehicle_brand_name":"Honda","vehicle_model_name":"SH"}
/// img_prefix : "https://stagingtest.alotoday.vn/uploads/user_personal_images/"
/// user_personal_images : [{"id":"1","user_id":"1198","portrait":"723c2d0e707436ac65e04cb43fc046_05386838_img_1920x_654dda5ceba974-55368403-92167003.jpg","CCCD_front":"8dfb72c3b94005c165e04cb441efe6_52632673_img_1920x_654dda5ceba974-55368403-92167003.jpg","CCCD_back":"32a7eea153e7da4465e04cb442a676_76033852_img_1920x_654dda5ceba974-55368403-92167003.jpg","driving_license_front":null,"driving_license_back":"5c574dc0f87d8ff465e04cb4435b28_20876323_img_1920x_654dda5ceba974-55368403-92167003.jpg","vehicle_registration_certificate_front":"1baaedf6220757f165e04cb4441346_09519589_img_1920x_654dda5ceba974-55368403-92167003.jpg","vehicle_registration_certificate_back":"55ba211a8b23574c65e04cb444c786_02981054_img_1920x_654dda5ceba974-55368403-92167003.jpg","vehicle_front":"f608ba7743c5cf4b65e04cb4454d63_97056678_img_1920x_654dda5ceba974-55368403-92167003.jpg","vehicle_left":"292b86616fe66f1a65e04cb445d0e9_42668884_img_1920x_654dda5ceba974-55368403-92167003.jpg","vehicle_right":"9424ca963592ed0165e04cb4465475_75829333_img_1920x_654dda5ceba974-55368403-92167003.jpg","vehicle_number_plate":null,"created_at":null,"updated_at":null}]

class UserInfoRes {
  UserInfoRes({
      this.status, 
      this.userInfo, 
      this.imgPrefix, 
      this.userPersonalImages,});

  UserInfoRes.fromJson(dynamic json) {
    status = json['status'];
    userInfo = json['user_info'] != null ? UserInfoVerify.fromJson(json['user_info']) : null;
    imgPrefix = json['img_prefix'];
    if (json['user_personal_images'] != null) {
      userPersonalImages = [];
      json['user_personal_images'].forEach((v) {
        userPersonalImages?.add(UserPersonalImages.fromJson(v));
      });
    }
  }
  bool? status;
  UserInfoVerify? userInfo;
  String? imgPrefix;
  List<UserPersonalImages>? userPersonalImages;
UserInfoRes copyWith({  bool? status,
  UserInfoVerify? userInfo,
  String? imgPrefix,
  List<UserPersonalImages>? userPersonalImages,
}) => UserInfoRes(  status: status ?? this.status,
  userInfo: userInfo ?? this.userInfo,
  imgPrefix: imgPrefix ?? this.imgPrefix,
  userPersonalImages: userPersonalImages ?? this.userPersonalImages,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (userInfo != null) {
      map['user_info'] = userInfo?.toJson();
    }
    map['img_prefix'] = imgPrefix;
    if (userPersonalImages != null) {
      map['user_personal_images'] = userPersonalImages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// user_id : "1198"
/// portrait : "723c2d0e707436ac65e04cb43fc046_05386838_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// CCCD_front : "8dfb72c3b94005c165e04cb441efe6_52632673_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// CCCD_back : "32a7eea153e7da4465e04cb442a676_76033852_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// driving_license_front : null
/// driving_license_back : "5c574dc0f87d8ff465e04cb4435b28_20876323_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// vehicle_registration_certificate_front : "1baaedf6220757f165e04cb4441346_09519589_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// vehicle_registration_certificate_back : "55ba211a8b23574c65e04cb444c786_02981054_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// vehicle_front : "f608ba7743c5cf4b65e04cb4454d63_97056678_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// vehicle_left : "292b86616fe66f1a65e04cb445d0e9_42668884_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// vehicle_right : "9424ca963592ed0165e04cb4465475_75829333_img_1920x_654dda5ceba974-55368403-92167003.jpg"
/// vehicle_number_plate : null
/// created_at : null
/// updated_at : null

class UserPersonalImages {
  UserPersonalImages({
      this.id, 
      this.userId, 
      this.portrait, 
      this.cCCDFront, 
      this.cCCDBack, 
      this.drivingLicenseFront, 
      this.drivingLicenseBack, 
      this.vehicleRegistrationCertificateFront, 
      this.vehicleRegistrationCertificateBack, 
      this.vehicleFront, 
      this.vehicleLeft, 
      this.vehicleRight, 
      this.vehicleNumberPlate, 
      this.createdAt, 
      this.updatedAt,});

  UserPersonalImages.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    portrait = json['portrait'];
    cCCDFront = json['CCCD_front'];
    cCCDBack = json['CCCD_back'];
    drivingLicenseFront = json['driving_license_front'];
    drivingLicenseBack = json['driving_license_back'];
    vehicleRegistrationCertificateFront = json['vehicle_registration_certificate_front'];
    vehicleRegistrationCertificateBack = json['vehicle_registration_certificate_back'];
    vehicleFront = json['vehicle_front'];
    vehicleLeft = json['vehicle_left'];
    vehicleRight = json['vehicle_right'];
    vehicleNumberPlate = json['vehicle_number_plate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? userId;
  String? portrait;
  String? cCCDFront;
  String? cCCDBack;
  dynamic drivingLicenseFront;
  String? drivingLicenseBack;
  String? vehicleRegistrationCertificateFront;
  String? vehicleRegistrationCertificateBack;
  String? vehicleFront;
  String? vehicleLeft;
  String? vehicleRight;
  dynamic vehicleNumberPlate;
  dynamic createdAt;
  dynamic updatedAt;
UserPersonalImages copyWith({  String? id,
  String? userId,
  String? portrait,
  String? cCCDFront,
  String? cCCDBack,
  dynamic drivingLicenseFront,
  String? drivingLicenseBack,
  String? vehicleRegistrationCertificateFront,
  String? vehicleRegistrationCertificateBack,
  String? vehicleFront,
  String? vehicleLeft,
  String? vehicleRight,
  dynamic vehicleNumberPlate,
  dynamic createdAt,
  dynamic updatedAt,
}) => UserPersonalImages(  id: id ?? this.id,
  userId: userId ?? this.userId,
  portrait: portrait ?? this.portrait,
  cCCDFront: cCCDFront ?? this.cCCDFront,
  cCCDBack: cCCDBack ?? this.cCCDBack,
  drivingLicenseFront: drivingLicenseFront ?? this.drivingLicenseFront,
  drivingLicenseBack: drivingLicenseBack ?? this.drivingLicenseBack,
  vehicleRegistrationCertificateFront: vehicleRegistrationCertificateFront ?? this.vehicleRegistrationCertificateFront,
  vehicleRegistrationCertificateBack: vehicleRegistrationCertificateBack ?? this.vehicleRegistrationCertificateBack,
  vehicleFront: vehicleFront ?? this.vehicleFront,
  vehicleLeft: vehicleLeft ?? this.vehicleLeft,
  vehicleRight: vehicleRight ?? this.vehicleRight,
  vehicleNumberPlate: vehicleNumberPlate ?? this.vehicleNumberPlate,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['portrait'] = portrait;
    map['CCCD_front'] = cCCDFront;
    map['CCCD_back'] = cCCDBack;
    map['driving_license_front'] = drivingLicenseFront;
    map['driving_license_back'] = drivingLicenseBack;
    map['vehicle_registration_certificate_front'] = vehicleRegistrationCertificateFront;
    map['vehicle_registration_certificate_back'] = vehicleRegistrationCertificateBack;
    map['vehicle_front'] = vehicleFront;
    map['vehicle_left'] = vehicleLeft;
    map['vehicle_right'] = vehicleRight;
    map['vehicle_number_plate'] = vehicleNumberPlate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : "1198"
/// first_name : "Nguyễn hoàng nam"
/// phone_number : "03524031401"
/// email : "nctri01111@gmail.com"
/// address : "aaaaaaaaaa"
/// province_id : "75"
/// district_id : "742"
/// ward_id : "26494"
/// loaixe : "1"
/// sochongoi : "0"
/// biensoxe : "60SHJS-DF"
/// vehicle_model_id : "1"
/// vehicle_brand_id : "1"
/// vehicle_year : "2021"
/// province_name : "Đồng Nai"
/// district_name : "Huyện Nhơn Trạch"
/// ward_name : "Xã Long Thọ"
/// vehicle_brand_name : "Honda"
/// vehicle_model_name : "SH"

class UserInfoVerify {
  UserInfoVerify({
      this.id, 
      this.firstName, 
      this.phoneNumber, 
      this.email, 
      this.address, 
      this.provinceId, 
      this.districtId, 
      this.wardId, 
      this.loaixe, 
      this.sochongoi, 
      this.biensoxe, 
      this.vehicleModelId, 
      this.vehicleBrandId, 
      this.vehicleYear, 
      this.provinceName, 
      this.districtName, 
      this.wardName, 
      this.vehicleBrandName, 
      this.vehicleModelName,});

  UserInfoVerify.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    address = json['address'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    loaixe = json['loaixe'];
    sochongoi = json['sochongoi'];
    biensoxe = json['biensoxe'];
    vehicleModelId = json['vehicle_model_id'];
    vehicleBrandId = json['vehicle_brand_id'];
    vehicleYear = json['vehicle_year'];
    provinceName = json['province_name'];
    districtName = json['district_name'];
    wardName = json['ward_name'];
    vehicleBrandName = json['vehicle_brand_name'];
    vehicleModelName = json['vehicle_model_name'];
  }
  String? id;
  String? firstName;
  String? phoneNumber;
  String? email;
  String? address;
  String? provinceId;
  String? districtId;
  String? wardId;
  String? loaixe;
  String? sochongoi;
  String? biensoxe;
  String? vehicleModelId;
  String? vehicleBrandId;
  String? vehicleYear;
  String? provinceName;
  String? districtName;
  String? wardName;
  String? vehicleBrandName;
  String? vehicleModelName;
UserInfoVerify copyWith({  String? id,
  String? firstName,
  String? phoneNumber,
  String? email,
  String? address,
  String? provinceId,
  String? districtId,
  String? wardId,
  String? loaixe,
  String? sochongoi,
  String? biensoxe,
  String? vehicleModelId,
  String? vehicleBrandId,
  String? vehicleYear,
  String? provinceName,
  String? districtName,
  String? wardName,
  String? vehicleBrandName,
  String? vehicleModelName,
}) => UserInfoVerify(  id: id ?? this.id,
  firstName: firstName ?? this.firstName,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  email: email ?? this.email,
  address: address ?? this.address,
  provinceId: provinceId ?? this.provinceId,
  districtId: districtId ?? this.districtId,
  wardId: wardId ?? this.wardId,
  loaixe: loaixe ?? this.loaixe,
  sochongoi: sochongoi ?? this.sochongoi,
  biensoxe: biensoxe ?? this.biensoxe,
  vehicleModelId: vehicleModelId ?? this.vehicleModelId,
  vehicleBrandId: vehicleBrandId ?? this.vehicleBrandId,
  vehicleYear: vehicleYear ?? this.vehicleYear,
  provinceName: provinceName ?? this.provinceName,
  districtName: districtName ?? this.districtName,
  wardName: wardName ?? this.wardName,
  vehicleBrandName: vehicleBrandName ?? this.vehicleBrandName,
  vehicleModelName: vehicleModelName ?? this.vehicleModelName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['phone_number'] = phoneNumber;
    map['email'] = email;
    map['address'] = address;
    map['province_id'] = provinceId;
    map['district_id'] = districtId;
    map['ward_id'] = wardId;
    map['loaixe'] = loaixe;
    map['sochongoi'] = sochongoi;
    map['biensoxe'] = biensoxe;
    map['vehicle_model_id'] = vehicleModelId;
    map['vehicle_brand_id'] = vehicleBrandId;
    map['vehicle_year'] = vehicleYear;
    map['province_name'] = provinceName;
    map['district_name'] = districtName;
    map['ward_name'] = wardName;
    map['vehicle_brand_name'] = vehicleBrandName;
    map['vehicle_model_name'] = vehicleModelName;
    return map;
  }

}