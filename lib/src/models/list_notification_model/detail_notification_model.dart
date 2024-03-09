import 'package:app_shipper/src/models/list_notification_model/list_new_model.dart';

/// status : true
/// mess : "Get data successfully!"
/// data : {"id":"32","title":"Đăng kí tài xế - Nhận ngay 500k","content":"Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản","image":"https://stagingtest.alotoday.vn/assets/img/notifications/1709198103_360_F_105907729_4RzHYsHJ2UFt5koUI19fc6VzyFPEjeXe.jpg","created_at":"2024-02-29 15:50:10","updated_at":"2024-02-29 16:15:03","type":"news","link":"","full_content":"<p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p><strong>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</strong></p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p><em>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</em></p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>😍🥰😘</p><p>😍🥰😘</p>","status":"1","user_type":"[\"shipper\",\"member\"]"}

class DetailNotificationModel {
  DetailNotificationModel({
      this.status, 
      this.mess, 
      this.data,});

  DetailNotificationModel.fromJson(dynamic json) {
    status = json['status'];
    mess = json['mess'];
    data = json['data'] != null ? NotificationNewModel.fromJson(json['data']) : null;
  }
  bool? status;
  String? mess;
  NotificationNewModel? data;
DetailNotificationModel copyWith({  bool? status,
  String? mess,
  NotificationNewModel? data,
}) => DetailNotificationModel(  status: status ?? this.status,
  mess: mess ?? this.mess,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['mess'] = mess;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}