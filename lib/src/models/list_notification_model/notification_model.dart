import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../configs/gen/assets.gen.dart';
import '../../configs/palette.dart';
import '../list_order_model/order.dart';

// class NotificationModel extends Equatable {
//   final String? id;
//   final String? transactionId;
//   final String? userId;
//   final String? token;
//   final String? title;
//   final String? createdAt;
//   final String? message;
//   final String? type;
//   final Order? orderObj;
//
//   const NotificationModel({
//     this.id,
//     this.transactionId,
//     this.userId,
//     this.token,
//     this.title,
//     this.createdAt,
//     this.message,
//     this.type,
//     this.orderObj,
//   });
//
//   factory NotificationModel.fromJson(Map<String, Object?> json) =>
//       NotificationModel(
//         id: json['id'] as String?,
//         transactionId: json['transaction_id'] as String?,
//         userId: json['user_id'] as String?,
//         token: json['token'] as String?,
//         title: json['title'] as String?,
//         createdAt: json['created_at'] as String?,
//         message: json['message'] as String?,
//         type: json['type'] as String?,
//         orderObj: json['order_obj'] == null
//             ? null
//             : Order.fromJson(json['order_obj']! as Map<String, Object?>),
//       );
//
//   Map<String, Object?> toJson() => {
//         'id': id,
//         'transaction_id': transactionId,
//         'user_id': userId,
//         'token': token,
//         'title': title,
//         'created_at': createdAt,
//         'message': message,
//         'type': type,
//         'order_obj': orderObj?.toJson(),
//       };
//
//   NotificationModel copyWith({
//     String? id,
//     String? transactionId,
//     String? userId,
//     String? token,
//     String? title,
//     String? createdAt,
//     String? message,
//     String? type,
//     Order? orderObj,
//   }) {
//     return NotificationModel(
//       id: id ?? this.id,
//       transactionId: transactionId ?? this.transactionId,
//       userId: userId ?? this.userId,
//       token: token ?? this.token,
//       title: title ?? this.title,
//       createdAt: createdAt ?? this.createdAt,
//       message: message ?? this.message,
//       type: type ?? this.type,
//       orderObj: orderObj ?? this.orderObj,
//     );
//   }
//
//   @override
//   bool get stringify => true;
//
//   @override
//   List<Object?> get props {
//     return [
//       id,
//       transactionId,
//       userId,
//       token,
//       title,
//       createdAt,
//       message,
//       type,
//       orderObj,
//     ];
//   }
// }
class NotificationModel extends Equatable {
  String? id;
  String? transactionId;
  String? userId;
  List<ListNotificationModel>? notifications;
  String? latestStatus;
  String? latestTime;
  OrderInfoModel? orderInfo;
  String? groupType;
  String? groupTypeText;

  NotificationModel(
      {this.id,
        this.transactionId,
        this.userId,
        this.notifications,
        this.latestStatus,
        this.latestTime,
        this.orderInfo,
        this.groupType,
        this.groupTypeText});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    userId = json['user_id'];
    if (json['notifications'] != null) {
      notifications = <ListNotificationModel>[];
      json['notifications'].forEach((v) {
        notifications!.add(ListNotificationModel.fromJson(v));
      });
    }
    latestStatus = json['latest_status'];
    latestTime = json['latest_time'];
    orderInfo = json['order_info'] != null
        ? OrderInfoModel.fromJson(json['order_info'])
        : null;
    groupType = json['group_type'];
    groupTypeText = json['group_type_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['user_id'] = userId;
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    data['latest_status'] = latestStatus;
    data['latest_time'] = latestTime;
    if (orderInfo != null) {
      data['order_info'] = orderInfo!.toJson();
    }
    data['group_type'] = groupType;
    data['group_type_text'] = groupTypeText;
    return data;
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    id,
    userId,
    notifications,
    latestStatus,
    latestTime,
    orderInfo,
    groupType,
    groupTypeText,
  ];

  String get getTime {
    if (latestTime != null) {
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime targetTime = format.parse(latestTime!);

      return '${targetTime.hour}:${targetTime.minute}';
    }

    return '';
  }

  String get getDate {
    if (latestTime != null) {
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime targetTime = format.parse(latestTime!);

      return '${targetTime.day}/${targetTime.month}';
    }

    return '';
  }

  List<ListNotificationModel> get getListNoties => notifications ?? [];

  String? get getOrderId => orderInfo?.id;

  String get getOrderNumber {
    if (orderInfo != null) {
      return orderInfo!.orderNumber ?? '';
    }
    return '';
  }

  String get getNotiStatus => latestStatus ?? '';

  String get getNotiType => groupTypeText ?? '';

  String get getTitleNoti {
    if (groupType == 'thanhtoan') {
      return 'Thanh toán';
    } else if (groupType == 'goixe') {
      return 'Gọi xe';
    } else if (groupType == 'donhang') {
      return 'Đơn hàng #${getOrderNumber}';
    }
    return '';
  }

  String? get getOrderStatus => orderInfo?.orderStatus;

  String? get getOrderStatusLabel {
    if (getOrderStatus == null) return null;

    switch (getOrderStatus) {
      case 'completed':
        return 'Đã hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Đang xử lý';
    }
  }

  Color get getColorStatus {
    if (getOrderStatus == null) return Palette.black;

    switch (getOrderStatus) {
      case 'completed':
        return Palette.success;
      case 'cancelled':
        return Palette.primary;
      default:
        return Palette.linkBlue;
    }
  }

  Color get getBgColorStatus {
    switch (getOrderStatus) {
      case '':
        return Palette.white;
      case 'completed':
        return Palette.success.withOpacity(0.1);
      case 'cancelled':
        return Palette.primary.withOpacity(0.1);
      default:
        return Palette.linkBlue.withOpacity(0.1);
    }
  }

  Widget get getIconNoti {
    switch (groupType) {
      case 'thanhtoan':
        return Assets.images.statusWallet.image(width: 24.w, height: 24.w);
      case 'goixe':
        return Assets.images.statusMotobike.image(width: 24.w, height: 24.w);
      case 'donhang':
        return Assets.images.statusShoppingCard
            .image(width: 24.w, height: 24.w);
      default:
        return const SizedBox();
    }
  }
}

class ListNotificationModel {
  String? id;
  String? transactionId;
  String? userId;
  String? token;
  String? title;
  String? createdAt;
  String? message;
  String? type;

  ListNotificationModel(
      {this.id,
        this.transactionId,
        this.userId,
        this.token,
        this.title,
        this.createdAt,
        this.message,
        this.type});

  ListNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    userId = json['user_id'];
    token = json['token'];
    title = json['title'];
    createdAt = json['created_at'];
    message = json['message'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['user_id'] = userId;
    data['token'] = token;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['message'] = message;
    data['type'] = type;
    return data;
  }

  String get getMessage => message ?? '';

  String get getTitle => title ?? '';

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
      } else {
        DateFormat resultFormat = DateFormat("HH:mm dd/MM/yyyy");
        String resultTimeString = resultFormat.format(targetTime);
        return resultTimeString;
      }
    }
    return '';
  }
}

class OrderInfoModel {
  String? id;
  String? orderNumber;
  String? orderStatus;

  OrderInfoModel({this.id, this.orderNumber, this.orderStatus});

  OrderInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['order_status'] = orderStatus;
    return data;
  }
}
