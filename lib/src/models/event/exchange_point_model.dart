
import 'package:intl/intl.dart';

import '../../utils/app_enum.dart';

class ExchangePointResponse {
  bool? status;
  List<ExchangePointModel>? data;
  String? page;
  int? perPage;

  ExchangePointResponse({this.status, this.data, this.page, this.perPage});

  ExchangePointResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ExchangePointModel>[];
      json['data'].forEach((v) {
        data!.add(ExchangePointModel.fromJson(v));
      });
    }
    page = json['page'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['perPage'] = perPage;
    return data;
  }

  int get getTotalItemInPerPage => perPage ?? 10;
}

class ExchangePointModel {
  String? id;
  String? userId;
  String? totalPoints;
  String? totalMoney;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? totalDays;
  String? giftText;

  ExchangePointModel({
    this.id,
    this.userId,
    this.totalPoints,
    this.totalMoney,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.totalDays,
    this.giftText,
  });

  ExchangePointModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPoints = json['total_points'];
    totalMoney = json['total_money'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    totalDays = json['total_days'];
    giftText = json['gift_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_points'] = totalPoints;
    data['total_money'] = totalMoney;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    data['total_days'] = totalDays;
    data['gift_text'] = giftText;
    return data;
  }

  String get getDate {
    try {
      return DateFormat('dd/MM/yyyy')
          .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(createdAt ?? ''));
    } catch (e) {
      return '';
    }
  }

  String get getTime {
    try {
      return DateFormat('HH:mm')
          .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(createdAt ?? ''));
    } catch (e) {
      return '';
    }
  }

  String get getValueShowing {
    return giftText ?? '';
    // if (getExchangeType == ExchangeType.money) {
    //   return (totalMoney ?? '0').toSecondVnd;
    // }
    // if (getExchangeType == ExchangeType.day) {
    //   return '${(int.tryParse(totalDays ?? '0') ?? 0)} ngày';
    // }
    // return '';
  }

  ExchangeType get getExchangeType {
    switch (type) {
      case 'day':
        return ExchangeType.day;
      case 'money':
        return ExchangeType.money;
      default:
        return ExchangeType.none;
    }
  }
}
