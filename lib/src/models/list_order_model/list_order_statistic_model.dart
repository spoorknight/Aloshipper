import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../configs/config.dart';
import '../../utils/app_enum.dart';

/// status : true
/// mess : "Get data successfully!"
/// data : [{"id":"3031","order_number":"13031","buyer_id":"1031","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"168560","price_total":"168560","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-21 01:20:17","created_at":"2024-02-21 01:17:33","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"36.14","price_km":"0","order_status":"cancelled","lydohuy":"hvv","history":"{\"id\":\"3031\",\"order_number\":\"13031\",\"buyer_id\":\"1031\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"16856000\",\"price_total\":\"16856000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-21 08:17:33\",\"created_at\":\"2024-02-21 08:17:33\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"36.14\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3029","order_number":"13029","buyer_id":"1396","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"6974640","price_total":"6974640","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-20 14:23:47","created_at":"2024-02-20 14:23:05","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"1737.66","price_km":"0","order_status":"cancelled","lydohuy":"test","history":"{\"id\":\"3029\",\"order_number\":\"13029\",\"buyer_id\":\"1396\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"697464000\",\"price_total\":\"697464000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-20 21:23:05\",\"created_at\":\"2024-02-20 21:23:05\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"1737.66\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3028","order_number":"13028","buyer_id":"1396","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"6974640","price_total":"6974640","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-20 14:20:02","created_at":"2024-02-20 14:19:35","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"1737.66","price_km":"0","order_status":"cancelled","lydohuy":"ok","history":"{\"id\":\"3028\",\"order_number\":\"13028\",\"buyer_id\":\"1396\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"697464000\",\"price_total\":\"697464000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-20 21:19:35\",\"created_at\":\"2024-02-20 21:19:35\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"1737.66\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3027","order_number":"13027","buyer_id":"1396","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"6974640","price_total":"6974640","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-20 14:14:09","created_at":"2024-02-20 14:13:50","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"1737.66","price_km":"0","order_status":"cancelled","lydohuy":"test","history":"{\"id\":\"3027\",\"order_number\":\"13027\",\"buyer_id\":\"1396\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"697464000\",\"price_total\":\"697464000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-20 21:13:50\",\"created_at\":\"2024-02-20 21:13:50\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"1737.66\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3026","order_number":"13026","buyer_id":"1396","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"6773840","price_total":"6773840","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-20 14:12:53","created_at":"2024-02-20 14:12:29","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"1687.46","price_km":"0","order_status":"cancelled","lydohuy":"test","history":"{\"id\":\"3026\",\"order_number\":\"13026\",\"buyer_id\":\"1396\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"677384000\",\"price_total\":\"677384000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-20 21:12:29\",\"created_at\":\"2024-02-20 21:12:29\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"1687.46\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3023","order_number":"13023","buyer_id":"898","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"24100","price_total":"24100","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-20 09:25:02","created_at":"2024-02-20 09:14:27","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"4.02","price_km":"0","order_status":"cancelled","lydohuy":"Shipper đang bận không thể nhận đơn!","history":"{\"id\":\"3023\",\"order_number\":\"13023\",\"buyer_id\":\"898\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"2410000\",\"price_total\":\"2410000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-20 16:14:27\",\"created_at\":\"2024-02-20 16:14:27\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"4.02\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3022","order_number":"13022","buyer_id":"1031","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"168560","price_total":"168560","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-20 09:12:59","created_at":"2024-02-20 09:12:18","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"36.14","price_km":"0","order_status":"cancelled","lydohuy":"vhj","history":"{\"id\":\"3022\",\"order_number\":\"13022\",\"buyer_id\":\"1031\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"16856000\",\"price_total\":\"16856000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-20 16:12:44\",\"created_at\":\"2024-02-20 16:12:18\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"36.14\",\"price_km\":\"0\",\"order_status\":\"shipper_confirm\",\"lydohuy\":null,\"history\":\"{\\\"id\\\":\\\"3022\\\",\\\"order_number\\\":\\\"13022\\\",\\\"buyer_id\\\":\\\"1031\\\",\\\"buyer_type\\\":\\\"registered\\\",\\\"price_subtotal\\\":\\\"0\\\",\\\"price_vat\\\":\\\"0\\\",\\\"price_shipping\\\":\\\"16856000\\\",\\\"price_total\\\":\\\"16856000\\\",\\\"price_currency\\\":\\\"VND\\\",\\\"status\\\":\\\"0\\\",\\\"payment_method\\\":\\\"cod\\\",\\\"payment_status\\\":\\\"payment_for_cod\\\",\\\"updated_at\\\":\\\"2024-02-20 16:12:18\\\",\\\"created_at\\\":\\\"2024-02-20 16:12:18\\\",\\\"order_note\\\":\\\"\\\",\\\"seller_id\\\":\\\"0\\\",\\\"fromcart\\\":\\\"0\\\",\\\"dvgh\\\":\\\"3\\\",\\\"shipper_id\\\":\\\"1198\\\",\\\"km_hd_id\\\":\\\"0\\\",\\\"khuyenmai_hd\\\":null,\\\"giamgia\\\":\\\"0\\\",\\\"store_id\\\":\\\"0\\\",\\\"type\\\":\\\"1\\\",\\\"so_km\\\":\\\"36.14\\\",\\\"price_km\\\":\\\"0\\\",\\\"order_status\\\":\\\"wait_shipper\\\",\\\"lydohuy\\\":null,\\\"history\\\":null,\\\"voucher_discount\\\":\\\"0\\\",\\\"voucher_id\\\":\\\"0\\\",\\\"voucher_code\\\":null,\\\"voucher_type\\\":\\\"\\\",\\\"voucher_number_of_km\\\":null}\",\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3009","order_number":"13009","buyer_id":"1031","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"148560","price_total":"148560","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-03 09:43:32","created_at":"2024-02-03 09:43:07","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"36.14","price_km":"0","order_status":"cancelled","lydohuy":"hff","history":"{\"id\":\"3009\",\"order_number\":\"13009\",\"buyer_id\":\"1031\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"14856000\",\"price_total\":\"14856000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-03 16:43:07\",\"created_at\":\"2024-02-03 16:43:07\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"36.14\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3008","order_number":"13008","buyer_id":"1031","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"148560","price_total":"148560","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-03 09:41:38","created_at":"2024-02-03 09:40:46","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"36.14","price_km":"0","order_status":"cancelled","lydohuy":"udf","history":"{\"id\":\"3008\",\"order_number\":\"13008\",\"buyer_id\":\"1031\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"14856000\",\"price_total\":\"14856000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-03 16:40:46\",\"created_at\":\"2024-02-03 16:40:46\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"36.14\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"},{"id":"3007","order_number":"13007","buyer_id":"1031","buyer_type":"registered","price_subtotal":"0","price_vat":"0","price_shipping":"148560","price_total":"148560","price_currency":"VND","status":"-1","payment_method":"cod","payment_status":"payment_for_cod","updated_at":"2024-02-03 09:39:37","created_at":"2024-02-03 09:38:18","order_note":"","seller_id":"0","fromcart":"0","dvgh":"3","shipper_id":"1198","km_hd_id":"0","khuyenmai_hd":null,"giamgia":"0","store_id":"0","type":"1","so_km":"36.14","price_km":"0","order_status":"cancelled","lydohuy":"vcxf","history":"{\"id\":\"3007\",\"order_number\":\"13007\",\"buyer_id\":\"1031\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"14856000\",\"price_total\":\"14856000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-03 16:38:18\",\"created_at\":\"2024-02-03 16:38:18\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"36.14\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}","voucher_discount":"0","voucher_id":"0","voucher_code":null,"voucher_type":"","voucher_number_of_km":null,"shop_name":null,"order_title":"Đơn gọi xe","order_status_text":"Đã hủy","payment_method_text":"Tiền mặt"}]

class ListOrderStatisticModel {
  ListOrderStatisticModel({
      this.status, 
      this.mess, 
      this.data,});

  ListOrderStatisticModel.fromJson(dynamic json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(OrderStatisticModel.fromJson(v));
      });
    }
  }
  bool? status;
  String? mess;
  List<OrderStatisticModel>? data;
ListOrderStatisticModel copyWith({  bool? status,
  String? mess,
  List<OrderStatisticModel>? data,
}) => ListOrderStatisticModel(  status: status ?? this.status,
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

/// id : "3031"
/// order_number : "13031"
/// buyer_id : "1031"
/// buyer_type : "registered"
/// price_subtotal : "0"
/// price_vat : "0"
/// price_shipping : "168560"
/// price_total : "168560"
/// price_currency : "VND"
/// status : "-1"
/// payment_method : "cod"
/// payment_status : "payment_for_cod"
/// updated_at : "2024-02-21 01:20:17"
/// created_at : "2024-02-21 01:17:33"
/// order_note : ""
/// seller_id : "0"
/// fromcart : "0"
/// dvgh : "3"
/// shipper_id : "1198"
/// km_hd_id : "0"
/// khuyenmai_hd : null
/// giamgia : "0"
/// store_id : "0"
/// type : "1"
/// so_km : "36.14"
/// price_km : "0"
/// order_status : "cancelled"
/// lydohuy : "hvv"
/// history : "{\"id\":\"3031\",\"order_number\":\"13031\",\"buyer_id\":\"1031\",\"buyer_type\":\"registered\",\"price_subtotal\":\"0\",\"price_vat\":\"0\",\"price_shipping\":\"16856000\",\"price_total\":\"16856000\",\"price_currency\":\"VND\",\"status\":\"0\",\"payment_method\":\"cod\",\"payment_status\":\"payment_for_cod\",\"updated_at\":\"2024-02-21 08:17:33\",\"created_at\":\"2024-02-21 08:17:33\",\"order_note\":\"\",\"seller_id\":\"0\",\"fromcart\":\"0\",\"dvgh\":\"3\",\"shipper_id\":\"1198\",\"km_hd_id\":\"0\",\"khuyenmai_hd\":null,\"giamgia\":\"0\",\"store_id\":\"0\",\"type\":\"1\",\"so_km\":\"36.14\",\"price_km\":\"0\",\"order_status\":\"wait_shipper\",\"lydohuy\":null,\"history\":null,\"voucher_discount\":\"0\",\"voucher_id\":\"0\",\"voucher_code\":null,\"voucher_type\":\"\",\"voucher_number_of_km\":null}"
/// voucher_discount : "0"
/// voucher_id : "0"
/// voucher_code : null
/// voucher_type : ""
/// voucher_number_of_km : null
/// shop_name : null
/// order_title : "Đơn gọi xe"
/// order_status_text : "Đã hủy"
/// payment_method_text : "Tiền mặt"

class OrderStatisticModel {
  OrderStatisticModel({
      this.id, 
      this.orderNumber, 
      this.buyerId, 
      this.buyerType, 
      this.priceSubtotal, 
      this.priceVat, 
      this.priceShipping, 
      this.priceTotal, 
      this.priceCurrency, 
      this.status, 
      this.paymentMethod, 
      this.paymentStatus, 
      this.updatedAt, 
      this.createdAt, 
      this.orderNote, 
      this.sellerId, 
      this.fromcart, 
      this.dvgh, 
      this.shipperId, 
      this.kmHdId, 
      this.khuyenmaiHd, 
      this.giamgia, 
      this.storeId, 
      this.type, 
      this.soKm, 
      this.priceKm, 
      this.orderStatus, 
      this.lydohuy, 
      this.history, 
      this.voucherDiscount, 
      this.voucherId, 
      this.voucherCode, 
      this.voucherType, 
      this.voucherNumberOfKm, 
      this.shopName, 
      this.orderTitle, 
      this.orderStatusText, 
      this.numberOfProducts,
      this.paymentMethodText,});

  OrderStatisticModel.fromJson(dynamic json) {
    id = json['id'];
    orderNumber = json['order_number'];
    buyerId = json['buyer_id'];
    buyerType = json['buyer_type'];
    priceSubtotal = json['price_subtotal'];
    priceVat = json['price_vat'];
    priceShipping = json['price_shipping'];
    priceTotal = json['price_total'];
    priceCurrency = json['price_currency'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    orderNote = json['order_note'];
    sellerId = json['seller_id'];
    fromcart = json['fromcart'];
    dvgh = json['dvgh'];
    shipperId = json['shipper_id'];
    kmHdId = json['km_hd_id'];
    khuyenmaiHd = json['khuyenmai_hd'];
    giamgia = json['giamgia'];
    storeId = json['store_id'];
    type = json['type'];
    soKm = json['so_km'];
    priceKm = json['price_km'];
    orderStatus = json['order_status'];
    lydohuy = json['lydohuy'];
    history = json['history'];
    voucherDiscount = json['voucher_discount'];
    voucherId = json['voucher_id'];
    voucherCode = json['voucher_code'];
    voucherType = json['voucher_type'];
    voucherNumberOfKm = json['voucher_number_of_km'];
    shopName = json['shop_name'];
    orderTitle = json['order_title'];
    orderStatusText = json['order_status_text'];
    paymentMethodText = json['payment_method_text'];
    numberOfProducts = json['number_of_products'];
  }
  String? id;
  String? orderNumber;
  String? buyerId;
  String? buyerType;
  String? priceSubtotal;
  String? priceVat;
  String? priceShipping;
  String? priceTotal;
  String? priceCurrency;
  String? status;
  String? paymentMethod;
  String? paymentStatus;
  String? updatedAt;
  String? createdAt;
  String? orderNote;
  String? sellerId;
  String? fromcart;
  String? dvgh;
  String? shipperId;
  String? kmHdId;
  dynamic khuyenmaiHd;
  String? giamgia;
  String? storeId;
  String? type;
  String? soKm;
  String? priceKm;
  String? orderStatus;
  String? lydohuy;
  String? history;
  String? voucherDiscount;
  String? voucherId;
  dynamic voucherCode;
  String? voucherType;
  dynamic voucherNumberOfKm;
  dynamic shopName;
  String? orderTitle;
  String? orderStatusText;
  String? paymentMethodText;
  int? numberOfProducts;
OrderStatisticModel copyWith({  String? id,
  String? orderNumber,
  String? buyerId,
  String? buyerType,
  String? priceSubtotal,
  String? priceVat,
  String? priceShipping,
  String? priceTotal,
  String? priceCurrency,
  String? status,
  String? paymentMethod,
  String? paymentStatus,
  String? updatedAt,
  String? createdAt,
  String? orderNote,
  String? sellerId,
  String? fromcart,
  String? dvgh,
  String? shipperId,
  String? kmHdId,
  dynamic khuyenmaiHd,
  String? giamgia,
  String? storeId,
  String? type,
  String? soKm,
  String? priceKm,
  String? orderStatus,
  String? lydohuy,
  String? history,
  String? voucherDiscount,
  String? voucherId,
  dynamic voucherCode,
  String? voucherType,
  dynamic voucherNumberOfKm,
  dynamic shopName,
  String? orderTitle,
  String? orderStatusText,
  String? paymentMethodText,
  int? numberOfProducts,
}) => OrderStatisticModel(  id: id ?? this.id,
  orderNumber: orderNumber ?? this.orderNumber,
  buyerId: buyerId ?? this.buyerId,
  buyerType: buyerType ?? this.buyerType,
  priceSubtotal: priceSubtotal ?? this.priceSubtotal,
  priceVat: priceVat ?? this.priceVat,
  priceShipping: priceShipping ?? this.priceShipping,
  priceTotal: priceTotal ?? this.priceTotal,
  priceCurrency: priceCurrency ?? this.priceCurrency,
  status: status ?? this.status,
  paymentMethod: paymentMethod ?? this.paymentMethod,
  paymentStatus: paymentStatus ?? this.paymentStatus,
  updatedAt: updatedAt ?? this.updatedAt,
  createdAt: createdAt ?? this.createdAt,
  orderNote: orderNote ?? this.orderNote,
  sellerId: sellerId ?? this.sellerId,
  fromcart: fromcart ?? this.fromcart,
  dvgh: dvgh ?? this.dvgh,
  shipperId: shipperId ?? this.shipperId,
  kmHdId: kmHdId ?? this.kmHdId,
  khuyenmaiHd: khuyenmaiHd ?? this.khuyenmaiHd,
  giamgia: giamgia ?? this.giamgia,
  storeId: storeId ?? this.storeId,
  type: type ?? this.type,
  soKm: soKm ?? this.soKm,
  priceKm: priceKm ?? this.priceKm,
  orderStatus: orderStatus ?? this.orderStatus,
  lydohuy: lydohuy ?? this.lydohuy,
  history: history ?? this.history,
  voucherDiscount: voucherDiscount ?? this.voucherDiscount,
  voucherId: voucherId ?? this.voucherId,
  voucherCode: voucherCode ?? this.voucherCode,
  voucherType: voucherType ?? this.voucherType,
  voucherNumberOfKm: voucherNumberOfKm ?? this.voucherNumberOfKm,
  shopName: shopName ?? this.shopName,
  orderTitle: orderTitle ?? this.orderTitle,
  orderStatusText: orderStatusText ?? this.orderStatusText,
  paymentMethodText: paymentMethodText ?? this.paymentMethodText,
  numberOfProducts: numberOfProducts ?? this.numberOfProducts,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_number'] = orderNumber;
    map['buyer_id'] = buyerId;
    map['buyer_type'] = buyerType;
    map['price_subtotal'] = priceSubtotal;
    map['price_vat'] = priceVat;
    map['price_shipping'] = priceShipping;
    map['price_total'] = priceTotal;
    map['price_currency'] = priceCurrency;
    map['status'] = status;
    map['payment_method'] = paymentMethod;
    map['payment_status'] = paymentStatus;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['order_note'] = orderNote;
    map['seller_id'] = sellerId;
    map['fromcart'] = fromcart;
    map['dvgh'] = dvgh;
    map['shipper_id'] = shipperId;
    map['km_hd_id'] = kmHdId;
    map['khuyenmai_hd'] = khuyenmaiHd;
    map['giamgia'] = giamgia;
    map['store_id'] = storeId;
    map['type'] = type;
    map['so_km'] = soKm;
    map['price_km'] = priceKm;
    map['order_status'] = orderStatus;
    map['lydohuy'] = lydohuy;
    map['history'] = history;
    map['voucher_discount'] = voucherDiscount;
    map['voucher_id'] = voucherId;
    map['voucher_code'] = voucherCode;
    map['voucher_type'] = voucherType;
    map['voucher_number_of_km'] = voucherNumberOfKm;
    map['shop_name'] = shopName;
    map['order_title'] = orderTitle;
    map['order_status_text'] = orderStatusText;
    map['payment_method_text'] = paymentMethodText;
    return map;
  }


  String get getTime {
    if (createdAt != null && createdAt != '') {
      DateTime now = DateTime.now();
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime targetTime = format.parse(createdAt!);

      // Tính toán khoảng thời gian
      Duration difference = now.difference(targetTime);

      if (difference.inHours > 0 && difference.inHours <= 24) {
        return '${difference.inHours} giờ trước';
      } else if (difference.inMinutes > 0 && difference.inMinutes <= 60) {
        return '${difference.inMinutes} phút trước';
      } else if (difference.inSeconds > 0 && difference.inSeconds <= 60) {
        return 'vài phút trước';
      }
    }
    return '';
  }

  String get getDateCreate {
    if (createdAt != null && createdAt != '') {
      DateFormat resultFormat = DateFormat("dd/MM/yyyy");
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime targetTime = format.parse(createdAt!);
      String resultTimeString = resultFormat.format(targetTime);
      return resultTimeString;
    }
    return '';
  }

  PaymentMethodEnum get getPaymentMethod {
    if (paymentMethod == PaymentMethodEnum.cash.method) {
      return PaymentMethodEnum.cash;
    }
    if (paymentMethod == PaymentMethodEnum.coin.method) {
      return PaymentMethodEnum.coin;
    }
    return PaymentMethodEnum.unknown;
  }

  String get getStrPaymentMethod {
    switch (getPaymentMethod) {
      case PaymentMethodEnum.cash:
        return 'Tiền mặt';
      case PaymentMethodEnum.coin:
        return 'Chuyển khoản';
      default:
        return '';
    }
  }

  Widget? get getIconPaymentType {
    switch (getPaymentMethod) {
      case PaymentMethodEnum.cash:
        return Assets.svgs.wallet.svg(
          width: 24.sp,
          height: 20.sp,
        );
      case PaymentMethodEnum.coin:
        return Assets.svgs.transferBank.svg(
          width: 17.sp,
          height: 22.sp,
        );
      default:
        return null;
    }
  }

  Color get getColorPaymentType {
    switch (getPaymentMethod) {
      case PaymentMethodEnum.cash:
        return Palette.success;
      case PaymentMethodEnum.coin:
        return Palette.linkBlue;
      default:
        return Palette.white;
    }
  }

  Color get getColorStatus {
    switch (orderStatusText) {
      case 'Đã hoàn thành':
        return Palette.success;
      case 'Đã hủy':
        return Palette.primary;
      default:
        return Palette.linkBlue;
    }
  }

}