import 'package:flutter/material.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';

/// status : true
/// mess : "get settings successfully!"
/// data : [{"id":"1","title":"Giá km đầu","from_km":"0","to_km":"1","min_price":"3000","max_price":"10000","is_first_km":"1","created_at":"2024-02-19 10:22:49","updated_at":"2024-02-19 10:22:53","shipper_id":"1198","fee":"6000"},{"id":"2","title":"Giá >1km và <= 20km","from_km":"1","to_km":"20","min_price":"3000","max_price":"10000","is_first_km":"0","created_at":"2024-02-19 10:22:49","updated_at":"2024-02-19 10:22:53","shipper_id":"1198","fee":"5000"},{"id":"3","title":"Giá trên 20km","from_km":"20","to_km":"0","min_price":"3000","max_price":"10000","is_first_km":"0","created_at":"2024-02-19 10:22:49","updated_at":"2024-02-19 10:22:53","shipper_id":"1198","fee":"4000"}]

class RideHailingSettingModel {
  RideHailingSettingModel({
      this.status, 
      this.mess, 
      this.data,});

  RideHailingSettingModel.fromJson(dynamic json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PriceSetting.fromJson(v));
      });
    }
  }
  bool? status;
  String? mess;
  List<PriceSetting>? data;
RideHailingSettingModel copyWith({  bool? status,
  String? mess,
  List<PriceSetting>? data,
}) => RideHailingSettingModel(  status: status ?? this.status,
  mess: mess ?? this.mess,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['mess'] = mess;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// title : "Giá km đầu"
/// from_km : "0"
/// to_km : "1"
/// min_price : "3000"
/// max_price : "10000"
/// is_first_km : "1"
/// created_at : "2024-02-19 10:22:49"
/// updated_at : "2024-02-19 10:22:53"
/// shipper_id : "1198"
/// fee : "6000"

class PriceSetting {
  PriceSetting({
      this.id, 
      this.title, 
      this.fromKm, 
      this.toKm, 
      this.minPrice, 
      this.maxPrice, 
      this.isFirstKm, 
      this.createdAt, 
      this.updatedAt, 
      this.shipperId, 
      this.edtController,
      this.fee,});

  PriceSetting.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    fromKm = json['from_km'];
    toKm = json['to_km'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    isFirstKm = json['is_first_km'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shipperId = json['shipper_id'];
    fee = json['fee'];
    edtController = TextEditingController(text: fee?.formatNumber);
  }
  String? id;
  String? title;
  String? fromKm;
  String? toKm;
  String? minPrice;
  String? maxPrice;
  String? isFirstKm;
  String? createdAt;
  String? updatedAt;
  String? shipperId;
  String? fee;
  TextEditingController? edtController;

PriceSetting copyWith({  String? id,
  String? title,
  String? fromKm,
  String? toKm,
  String? minPrice,
  String? maxPrice,
  String? isFirstKm,
  String? createdAt,
  String? updatedAt,
  String? shipperId,
  String? fee,
  TextEditingController? edtController,
}) => PriceSetting(  id: id ?? this.id,
  title: title ?? this.title,
  fromKm: fromKm ?? this.fromKm,
  toKm: toKm ?? this.toKm,
  minPrice: minPrice ?? this.minPrice,
  maxPrice: maxPrice ?? this.maxPrice,
  isFirstKm: isFirstKm ?? this.isFirstKm,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  shipperId: shipperId ?? this.shipperId,
  fee: fee ?? this.fee,
  edtController: edtController ?? this.edtController,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['from_km'] = fromKm;
    map['to_km'] = toKm;
    map['min_price'] = minPrice;
    map['max_price'] = maxPrice;
    map['is_first_km'] = isFirstKm;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['shipper_id'] = shipperId;
    map['fee'] = fee;
    return map;
  }

}