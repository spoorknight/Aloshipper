class StoreForShareResponse {
  bool? status;
  List<StoreForShareModel>? list;
  int? perPage;
  String? page;

  StoreForShareResponse({this.status, this.list, this.perPage, this.page});

  StoreForShareResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['list'] != null) {
      list = <StoreForShareModel>[];
      json['list'].forEach((v) {
        list!.add(StoreForShareModel.fromJson(v));
      });
    }
    perPage = json['per_page'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    data['per_page'] = perPage;
    data['page'] = page;
    return data;
  }

  bool get isLastPage =>
      (list ?? []).isEmpty || (perPage ?? 1) > (list ?? []).length;
}

class StoreForShareModel {
  String? id;
  String? distance;
  String? firstName;
  String? coverImage;
  String? countryId;
  String? stateId;
  String? cityId;
  String? shopName;
  String? subdomain;
  String? posbasicUser;
  String? phoneNumber;
  String? address;
  String? shopOpenTime;
  String? shopCloseTime;
  String? shopOnline;
  String? mainJob;
  String? slug;
  String? latitude;
  String? longitude;
  String? userType;
  String? avatar;
  String? planEndDate;
  String? shopUrl;
  String? location;
  LocationObj? locationObj;
  String? shopOnlineText;
  bool? follow;
  int? hasVoucher;

  StoreForShareModel(
      {this.id,
      this.distance,
      this.firstName,
      this.coverImage,
      this.countryId,
      this.stateId,
      this.cityId,
      this.shopName,
      this.posbasicUser,
      this.phoneNumber,
      this.address,
      this.shopOpenTime,
      this.shopCloseTime,
      this.shopOnline,
      this.mainJob,
      this.slug,
      this.latitude,
      this.longitude,
      this.userType,
      this.avatar,
      this.planEndDate,
      this.shopUrl,
      this.location,
      this.locationObj,
      this.shopOnlineText,
      this.follow,
      this.subdomain,
      this.hasVoucher});

  StoreForShareModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distance = json['distance'];
    firstName = json['first_name'];
    coverImage = json['cover_image'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    shopName = json['shop_name'];
    posbasicUser = json['posbasic_user'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    shopOpenTime = json['shop_open_time'];
    shopCloseTime = json['shop_close_time'];
    shopOnline = json['shop_online'];
    mainJob = json['main_job'];
    slug = json['slug'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userType = json['user_type'];
    avatar = json['avatar'];
    planEndDate = json['plan_end_date'];
    shopUrl = json['shop_url'];
    location = json['location'];
    subdomain = json['subdomain'];
    locationObj = json['location_obj'] != null
        ? LocationObj.fromJson(json['location_obj'])
        : null;
    shopOnlineText = json['shop_online_text'];
    follow = json['follow'];
    hasVoucher = json['hasVoucher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['distance'] = distance;
    data['first_name'] = firstName;
    data['cover_image'] = coverImage;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['shop_name'] = shopName;
    data['posbasic_user'] = posbasicUser;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['shop_open_time'] = shopOpenTime;
    data['shop_close_time'] = shopCloseTime;
    data['shop_online'] = shopOnline;
    data['main_job'] = mainJob;
    data['slug'] = slug;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['user_type'] = userType;
    data['avatar'] = avatar;
    data['plan_end_date'] = planEndDate;
    data['shop_url'] = shopUrl;
    data['location'] = location;
    if (locationObj != null) {
      data['location_obj'] = locationObj!.toJson();
    }
    data['shop_online_text'] = shopOnlineText;
    data['follow'] = follow;
    data['hasVoucher'] = hasVoucher;
    data['subdomain'] = subdomain;
    return data;
  }
}

class LocationObj {
  String? countryId;
  String? stateId;
  String? cityId;

  LocationObj({this.countryId, this.stateId, this.cityId});

  LocationObj.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    return data;
  }
}
