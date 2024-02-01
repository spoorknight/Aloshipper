
import 'package:app_shipper/src/utils/extensions/format_string.dart';

class ReferFriendResponse {
  bool? status;
  String? mess;
  List<ReferFriendModel>? data;

  ReferFriendResponse({this.status, this.mess, this.data});

  ReferFriendResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = <ReferFriendModel>[];
      json['data'].forEach((v) {
        data!.add(ReferFriendModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['mess'] = mess;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferFriendModel {
  String? id;
  String? firstName;
  String? phoneNumber;
  String? countAdViews;
  String? countCompletedOrders;
  String? avatar;
  String? adViewsProgress;
  String? completedFirstOrderStatus;

  ReferFriendModel(
      {this.id,
      this.firstName,
      this.phoneNumber,
      this.countAdViews,
      this.countCompletedOrders,
      this.avatar,
      this.adViewsProgress,
      this.completedFirstOrderStatus});

  ReferFriendModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    phoneNumber = json['phone_number'];
    countAdViews = json['count_ad_views'];
    countCompletedOrders = json['count_completed_orders'];
    avatar = json['avatar'];
    adViewsProgress = json['ad_views_progress'];
    completedFirstOrderStatus = json['completed_first_order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['phone_number'] = phoneNumber;
    data['count_ad_views'] = countAdViews;
    data['count_completed_orders'] = countCompletedOrders;
    data['avatar'] = avatar;
    data['ad_views_progress'] = adViewsProgress;
    data['completed_first_order_status'] = completedFirstOrderStatus;
    return data;
  }

  String get getName => firstName ?? '';

  String get getNameAvatar => getName.isNotEmpty ? getName[0].toUpperCase() : '';

  String get getPhoneNumber => (phoneNumber ?? '').hidePhoneNumber();

  String get getCountOrder => countCompletedOrders ?? '0';

  String get getStringAds => adViewsProgress ?? '';
}
