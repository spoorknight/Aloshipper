/// status : true
/// mess : "Get data successfully!"
/// data : {"unreadCount":1}

class CountUnreadNewModel {
  CountUnreadNewModel({
      this.status, 
      this.mess, 
      this.data,});

  CountUnreadNewModel.fromJson(dynamic json) {
    status = json['status'];
    mess = json['mess'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? mess;
  Data? data;
CountUnreadNewModel copyWith({  bool? status,
  String? mess,
  Data? data,
}) => CountUnreadNewModel(  status: status ?? this.status,
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

/// unreadCount : 1

class Data {
  Data({
      this.unreadCount,});

  Data.fromJson(dynamic json) {
    unreadCount = json['unreadCount'];
  }
  int? unreadCount;
Data copyWith({  int? unreadCount,
}) => Data(  unreadCount: unreadCount ?? this.unreadCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unreadCount'] = unreadCount;
    return map;
  }

}