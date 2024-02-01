class ResponseCancelOrderModel {
  bool? status;
  String? mess;
  List<ReasonCancelOrderModel>? data;

  ResponseCancelOrderModel({this.status, this.mess, this.data});

  ResponseCancelOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = <ReasonCancelOrderModel>[];
      json['data'].forEach((v) {
        data!.add(ReasonCancelOrderModel.fromJson(v));
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

class ReasonCancelOrderModel {
  String? id;
  String? content;
  String? createdAt;
  String? updatedAt;

  ReasonCancelOrderModel({this.id, this.content, this.createdAt, this.updatedAt});

  ReasonCancelOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
