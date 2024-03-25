/// title : "Phí dịch vụ"
/// fee : "0"
/// description : "mô tả 1"

class ServiceFeeInfoModel {
  ServiceFeeInfoModel({
      this.title, 
      this.fee, 
      this.description,});

  ServiceFeeInfoModel.fromJson(dynamic json) {
    title = json['title'];
    fee = json['fee'];
    description = json['description'];
  }
  String? title;
  String? fee;
  String? description;
ServiceFeeInfoModel copyWith({  String? title,
  String? fee,
  String? description,
}) => ServiceFeeInfoModel(  title: title ?? this.title,
  fee: fee ?? this.fee,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['fee'] = fee;
    map['description'] = description;
    return map;
  }

}