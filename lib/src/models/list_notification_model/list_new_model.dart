/// status : true
/// mess : "get data successfully!"
/// data : [{"id":"32","title":"Đăng kí tài xế - Nhận ngay 500k","content":"Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản","image":"https://stagingtest.alotoday.vn/assets/img/notifications/1709198103_360_F_105907729_4RzHYsHJ2UFt5koUI19fc6VzyFPEjeXe.jpg","created_at":"2024-02-29 15:50:10","updated_at":"2024-02-29 16:15:03","type":"news","link":"","full_content":"<p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p><strong>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</strong></p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p><em>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</em></p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>😍🥰😘</p><p>😍🥰😘</p>","status":"1","user_type":"[\"shipper\",\"member\"]","is_read":false}]

class ListNewModel {
  ListNewModel({
      this.status, 
      this.mess, 
      this.data,});

  ListNewModel.fromJson(dynamic json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationNewModel.fromJson(v));
      });
    }
  }
  bool? status;
  String? mess;
  List<NotificationNewModel>? data;
ListNewModel copyWith({  bool? status,
  String? mess,
  List<NotificationNewModel>? data,
}) => ListNewModel(  status: status ?? this.status,
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

/// id : "32"
/// title : "Đăng kí tài xế - Nhận ngay 500k"
/// content : "Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản"
/// image : "https://stagingtest.alotoday.vn/assets/img/notifications/1709198103_360_F_105907729_4RzHYsHJ2UFt5koUI19fc6VzyFPEjeXe.jpg"
/// created_at : "2024-02-29 15:50:10"
/// updated_at : "2024-02-29 16:15:03"
/// type : "news"
/// link : ""
/// full_content : "<p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p><strong>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</strong></p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p><em>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</em></p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>Đăng kí trở thành tài xế - Nhận ngay 500k vào tài khoản</p><p>😍🥰😘</p><p>😍🥰😘</p>"
/// status : "1"
/// user_type : "[\"shipper\",\"member\"]"
/// is_read : false

class NotificationNewModel {
  NotificationNewModel({
      this.id, 
      this.title, 
      this.content, 
      this.image, 
      this.createdAt, 
      this.updatedAt, 
      this.type, 
      this.link, 
      this.fullContent, 
      this.status, 
      this.userType, 
      this.isRead,});

  NotificationNewModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    link = json['link'];
    fullContent = json['full_content'];
    status = json['status'];
    userType = json['user_type'];
    isRead = json['is_read'];
  }
  String? id;
  String? title;
  String? content;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? link;
  String? fullContent;
  String? status;
  String? userType;
  bool? isRead;
NotificationNewModel copyWith({  String? id,
  String? title,
  String? content,
  String? image,
  String? createdAt,
  String? updatedAt,
  String? type,
  String? link,
  String? fullContent,
  String? status,
  String? userType,
  bool? isRead,
}) => NotificationNewModel(  id: id ?? this.id,
  title: title ?? this.title,
  content: content ?? this.content,
  image: image ?? this.image,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  type: type ?? this.type,
  link: link ?? this.link,
  fullContent: fullContent ?? this.fullContent,
  status: status ?? this.status,
  userType: userType ?? this.userType,
  isRead: isRead ?? this.isRead,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['type'] = type;
    map['link'] = link;
    map['full_content'] = fullContent;
    map['status'] = status;
    map['user_type'] = userType;
    map['is_read'] = isRead;
    return map;
  }

}