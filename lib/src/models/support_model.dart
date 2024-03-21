class SupportModel {
  bool? status;
  String? mess;
  List<SupportDataModel>? data;

  SupportModel({this.status, this.mess, this.data});

  SupportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = <SupportDataModel>[];
      json['data'].forEach((v) {
        data!.add(SupportDataModel.fromJson(v));
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

class SupportDataModel {
  String? id;
  String? key;
  String? value;

  SupportDataModel({this.id, this.key, this.value});

  SupportDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
