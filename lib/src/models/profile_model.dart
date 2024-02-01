// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:app_shipper/src/utils/extensions/extensions.dart';

import '../utils/app_enum.dart';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status,
    this.expire,
    this.daysLeft,
    this.plan,
    this.memberId,
    this.token,
    this.shopId,
    this.item,
    this.mess,
  });

  bool? status;
  bool? expire;
  int? daysLeft;
  Plan? plan;
  String? memberId;
  String? token;
  String? shopId;
  Item? item;
  String? mess;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        expire: json["expire"],
        daysLeft: json["days_left"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        memberId: json["member_id"],
        token: json["token"],
        shopId: json["shop_id"],
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        mess: json["mess"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "expire": expire,
        "days_left": daysLeft,
        "plan": plan?.toJson(),
        "member_id": memberId,
        "token": token,
        "shop_id": shopId,
        "item": item?.toJson(),
        "mess": mess,
      };

  CustomerType get getCustomerType {
    String role = item?.user?.role ?? '';

    switch (role) {
      case 'vendor':
        return CustomerType.vendor;
      case 'shipper':
        return CustomerType.shipper;
      case 'member':
        return CustomerType.member;
      default:
        return CustomerType.none;
    }
  }
}

class Item {
  Item({
    this.user,
    this.profileUrl,
    this.userMainJob,
    this.userAvatar,
    this.generalSettings,
    this.giaypheps,
  });

  User? user;
  String? profileUrl;
  String? userMainJob;
  String? userAvatar;
  Map<String, String?>? generalSettings;
  List<String>? giaypheps;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        profileUrl: json["profile_url"],
        userMainJob: json["user_main_job"],
        userAvatar: json["user_avatar"],
        generalSettings: Map.from(json["general_settings"]!)
            .map((k, v) => MapEntry<String, String?>(k, v)),
        giaypheps: List<String>.from(json["giaypheps"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "profile_url": profileUrl,
        "user_main_job": userMainJob,
        "user_avatar": userAvatar,
        "general_settings": Map.from(generalSettings!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };

  String get getUserAmount => (user?.soDuTaiKhoan ?? 0).toString().toVnd;

  String get getUserName => (user?.firstName ?? '').toUpperCase();
}

class User {
  User({
    this.id,
    this.username,
    this.slug,
    this.email,
    this.emailStatus,
    this.token,
    this.password,
    this.role,
    this.balance,
    this.numberOfSales,
    this.userType,
    this.facebookId,
    this.googleId,
    this.vkontakteId,
    this.avatar,
    this.coverImage,
    this.coverImageType,
    this.banned,
    this.firstName,
    this.lastName,
    this.shopName,
    this.aboutMe,
    this.phoneNumber,
    this.countryId,
    this.stateId,
    this.cityId,
    this.address,
    this.latitude,
    this.longitude,
    this.zipCode,
    this.companyType,
    this.iso,
    this.mainJob,
    this.showEmail,
    this.showPhone,
    this.showLocation,
    this.personalWebsiteUrl,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.pinterestUrl,
    this.linkedinUrl,
    this.vkUrl,
    this.youtubeUrl,
    this.whatsappUrl,
    this.telegramUrl,
    this.lastSeen,
    this.showRssFeeds,
    this.sendEmailNewMessage,
    this.isActiveShopRequest,
    this.isMembershipPlanExpired,
    this.isUsedFreePlan,
    this.createdAt,
    this.posbasicUser,
    this.phanloaiType,
    this.notes,
    this.groupId,
    this.masothue,
    this.password1,
    this.loaixe,
    this.biensoxe,
    this.domain,
    this.fromcart,
    this.requestDate,
    this.magioithieu,
    this.phiKmDauTien,
    this.phigiaohang,
    this.phigoixe,
    this.shopOnline,
    this.shopOpenTime,
    this.shopCloseTime,
    this.phuongThucThanhToan,
    this.giaHanTuDong,
    this.henGiao,
    this.deviceToken,
    this.listDvgh,
    this.soDuTamGiu,
    this.soDuTaiKhoan,
    this.sochongoi,
    this.batGoiXe,
    this.batNhanHang,
  });

  String? id;
  String? username;
  String? slug;
  String? email;
  String? emailStatus;
  String? token;
  String? password;
  String? role;
  String? balance;
  String? numberOfSales;
  String? userType;
  dynamic facebookId;
  dynamic googleId;
  dynamic vkontakteId;
  String? avatar;
  dynamic coverImage;
  String? coverImageType;
  String? banned;
  String? firstName;
  dynamic lastName;
  String? shopName;
  String? aboutMe;
  String? phoneNumber;
  String? countryId;
  String? stateId;
  String? cityId;
  String? address;
  dynamic latitude;
  dynamic longitude;
  dynamic zipCode;
  String? companyType;
  String? iso;
  String? mainJob;
  String? showEmail;
  String? showPhone;
  String? showLocation;
  dynamic personalWebsiteUrl;
  dynamic facebookUrl;
  dynamic twitterUrl;
  dynamic instagramUrl;
  dynamic pinterestUrl;
  dynamic linkedinUrl;
  dynamic vkUrl;
  dynamic youtubeUrl;
  dynamic whatsappUrl;
  dynamic telegramUrl;
  DateTime? lastSeen;
  String? showRssFeeds;
  String? sendEmailNewMessage;
  String? isActiveShopRequest;
  String? isMembershipPlanExpired;
  String? isUsedFreePlan;
  DateTime? createdAt;
  String? posbasicUser;
  String? phanloaiType;
  dynamic notes;
  String? groupId;
  dynamic masothue;
  String? password1;
  String? loaixe;
  String? biensoxe;
  String? domain;
  String? fromcart;
  DateTime? requestDate;
  String? magioithieu;
  String? phiKmDauTien;
  String? phigiaohang;
  String? phigoixe;
  String? shopOnline;
  dynamic shopOpenTime;
  dynamic shopCloseTime;
  dynamic phuongThucThanhToan;
  String? giaHanTuDong;
  dynamic henGiao;
  String? deviceToken;
  dynamic listDvgh;
  int? soDuTamGiu;
  int? soDuTaiKhoan;
  String? sochongoi;
  String? batGoiXe;
  String? batNhanHang;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        batGoiXe: json["bat_goi_xe"],
        batNhanHang: json["bat_nhan_hang"],
        username: json["username"],
        slug: json["slug"],
        email: json["email"],
        emailStatus: json["email_status"],
        token: json["token"],
        password: json["password"],
        role: json["role"],
        balance: json["balance"],
        numberOfSales: json["number_of_sales"],
        userType: json["user_type"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        vkontakteId: json["vkontakte_id"],
        avatar: json["avatar"],
        coverImage: json["cover_image"],
        coverImageType: json["cover_image_type"],
        banned: json["banned"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        shopName: json["shop_name"],
        aboutMe: json["about_me"],
        phoneNumber: json["phone_number"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        zipCode: json["zip_code"],
        companyType: json["company_type"],
        iso: json["iso"],
        mainJob: json["main_job"],
        showEmail: json["show_email"],
        showPhone: json["show_phone"],
        showLocation: json["show_location"],
        personalWebsiteUrl: json["personal_website_url"],
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        instagramUrl: json["instagram_url"],
        pinterestUrl: json["pinterest_url"],
        linkedinUrl: json["linkedin_url"],
        vkUrl: json["vk_url"],
        youtubeUrl: json["youtube_url"],
        whatsappUrl: json["whatsapp_url"],
        telegramUrl: json["telegram_url"],
        lastSeen: json["last_seen"] == null
            ? null
            : DateTime.parse(json["last_seen"]),
        showRssFeeds: json["show_rss_feeds"],
        sendEmailNewMessage: json["send_email_new_message"],
        isActiveShopRequest: json["is_active_shop_request"],
        isMembershipPlanExpired: json["is_membership_plan_expired"],
        isUsedFreePlan: json["is_used_free_plan"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        posbasicUser: json["posbasic_user"],
        phanloaiType: json["phanloai_type"],
        notes: json["notes"],
        groupId: json["group_id"],
        masothue: json["masothue"],
        password1: json["password1"],
        loaixe: json["loaixe"],
        biensoxe: json["biensoxe"],
        domain: json["domain"],
        fromcart: json["fromcart"],
        requestDate: json["request_date"] == null
            ? null
            : DateTime.parse(json["request_date"]),
        magioithieu: json["magioithieu"],
        phiKmDauTien: json["fee_per_km"]?.toString(),
        phigiaohang: json["phigiaohang"].toString(),
        phigoixe: json["phigoixe"].toString(),
        shopOnline: json["shop_online"],
        shopOpenTime: json["shop_open_time"],
        shopCloseTime: json["shop_close_time"],
        phuongThucThanhToan: json["phuong_thuc_thanh_toan"],
        giaHanTuDong: json["gia_han_tu_dong"],
        henGiao: json["hen_giao"],
        deviceToken: json["device_token"],
        listDvgh: json["list_dvgh"],
        soDuTamGiu: json["so_du_tam_giu"],
        soDuTaiKhoan: json["so_du_tai_khoan"],
        sochongoi: json["sochongoi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "bat_goi_xe": batGoiXe,
        "bat_nhan_hang": batNhanHang,
        "slug": slug,
        "email": email,
        "email_status": emailStatus,
        "token": token,
        "password": password,
        "role": role,
        "balance": balance,
        "number_of_sales": numberOfSales,
        "user_type": userType,
        "facebook_id": facebookId,
        "google_id": googleId,
        "vkontakte_id": vkontakteId,
        "avatar": avatar,
        "cover_image": coverImage,
        "cover_image_type": coverImageType,
        "banned": banned,
        "first_name": firstName,
        "last_name": lastName,
        "shop_name": shopName,
        "about_me": aboutMe,
        "phone_number": phoneNumber,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "zip_code": zipCode,
        "company_type": companyType,
        "iso": iso,
        "main_job": mainJob,
        "show_email": showEmail,
        "show_phone": showPhone,
        "show_location": showLocation,
        "personal_website_url": personalWebsiteUrl,
        "facebook_url": facebookUrl,
        "twitter_url": twitterUrl,
        "instagram_url": instagramUrl,
        "pinterest_url": pinterestUrl,
        "linkedin_url": linkedinUrl,
        "vk_url": vkUrl,
        "youtube_url": youtubeUrl,
        "whatsapp_url": whatsappUrl,
        "telegram_url": telegramUrl,
        "last_seen": lastSeen?.toIso8601String(),
        "show_rss_feeds": showRssFeeds,
        "send_email_new_message": sendEmailNewMessage,
        "is_active_shop_request": isActiveShopRequest,
        "is_membership_plan_expired": isMembershipPlanExpired,
        "is_used_free_plan": isUsedFreePlan,
        "created_at": createdAt?.toIso8601String(),
        "posbasic_user": posbasicUser,
        "phanloai_type": phanloaiType,
        "notes": notes,
        "group_id": groupId,
        "masothue": masothue,
        "password1": password1,
        "loaixe": loaixe,
        "biensoxe": biensoxe,
        "domain": domain,
        "fromcart": fromcart,
        "request_date": requestDate?.toIso8601String(),
        "magioithieu": magioithieu,
        "fee_per_km": phiKmDauTien,
        "phigiaohang": phigiaohang,
        "phigoixe": phigoixe,
        "shop_online": shopOnline,
        "shop_open_time": shopOpenTime,
        "shop_close_time": shopCloseTime,
        "phuong_thuc_thanh_toan": phuongThucThanhToan,
        "gia_han_tu_dong": giaHanTuDong,
        "hen_giao": henGiao,
        "device_token": deviceToken,
        "list_dvgh": listDvgh,
        "so_du_tam_giu": soDuTamGiu,
        "so_du_tai_khoan": soDuTaiKhoan,
        "sochongoi": sochongoi,
      };

  bool get isOnBatGoiXe => batGoiXe == '1';

  bool get isOnBatNhanDon => batNhanHang == '1';
}

class Plan {
  Plan({
    this.id,
    this.userId,
    this.planId,
    this.planTitle,
    this.numberOfAds,
    this.numberOfDays,
    this.price,
    this.currency,
    this.isFree,
    this.isUnlimitedNumberOfAds,
    this.isUnlimitedTime,
    this.paymentMethod,
    this.paymentStatus,
    this.planStatus,
    this.planStartDate,
    this.planEndDate,
    this.maxStore,
  });

  String? id;
  String? userId;
  String? planId;
  String? planTitle;
  String? numberOfAds;
  String? numberOfDays;
  String? price;
  String? currency;
  String? isFree;
  String? isUnlimitedNumberOfAds;
  String? isUnlimitedTime;
  String? paymentMethod;
  String? paymentStatus;
  String? planStatus;
  DateTime? planStartDate;
  DateTime? planEndDate;
  String? maxStore;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        userId: json["user_id"],
        planId: json["plan_id"],
        planTitle: json["plan_title"],
        numberOfAds: json["number_of_ads"],
        numberOfDays: json["number_of_days"],
        price: json["price"],
        currency: json["currency"],
        isFree: json["is_free"],
        isUnlimitedNumberOfAds: json["is_unlimited_number_of_ads"],
        isUnlimitedTime: json["is_unlimited_time"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        planStatus: json["plan_status"],
        planStartDate: json["plan_start_date"] == null
            ? null
            : DateTime.parse(json["plan_start_date"]),
        planEndDate: json["plan_end_date"] == null
            ? null
            : DateTime.parse(json["plan_end_date"]),
        maxStore: json["max_store"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "plan_id": planId,
        "plan_title": planTitle,
        "number_of_ads": numberOfAds,
        "number_of_days": numberOfDays,
        "price": price,
        "currency": currency,
        "is_free": isFree,
        "is_unlimited_number_of_ads": isUnlimitedNumberOfAds,
        "is_unlimited_time": isUnlimitedTime,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "plan_status": planStatus,
        "plan_start_date": planStartDate?.toIso8601String(),
        "plan_end_date": planEndDate?.toIso8601String(),
        "max_store": maxStore,
      };
}
