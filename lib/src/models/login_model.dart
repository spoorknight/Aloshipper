// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.expire,
    this.isAutoBanned,
    this.daysLeft,
    this.plan,
    this.memberId,
    this.tokenlogin,
    this.mess,
    this.item,
  });

  bool? status;
  bool? expire;
  bool? isAutoBanned;
  int? daysLeft;
  Plan? plan;
  String? memberId;
  String? tokenlogin;
  String? mess;
  String? item;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        expire: json["expire"],
        isAutoBanned: json["is_auto_banned"],
        daysLeft: json["days_left"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        memberId: json["member_id"],
        tokenlogin: json["tokenlogin"],
        mess: json["mess"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "expire": expire,
        "is_auto_banned": isAutoBanned,
        "days_left": daysLeft,
        "plan": plan?.toJson(),
        "member_id": memberId,
        "tokenlogin": tokenlogin,
        "mess": mess,
      };
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
  String? planStartDate;
  String? planEndDate;
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
        planStartDate: json["plan_start_date"],
        planEndDate: json["plan_end_date"],
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
        "plan_start_date": planStartDate,
        "plan_end_date": planEndDate,
        "max_store": maxStore,
      };
}
