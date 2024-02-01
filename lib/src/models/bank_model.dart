class ResponseBankInfoModel {
  bool? status;
  String? mess;
  List<BankModel>? data;

  ResponseBankInfoModel({this.status, this.mess, this.data});

  ResponseBankInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = <BankModel>[];
      json['data'].forEach((v) {
        data!.add(BankModel.fromJson(v));
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

class BankModel {
  String? id;
  String? shortName;
  String? name;
  String? logo;
  String? code;
  String? bin;

  BankModel(
      {this.id, this.shortName, this.name, this.logo, this.code, this.bin});

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortName = json['short_name'];
    name = json['name'];
    logo = json['logo'];
    code = json['code'];
    bin = json['bin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['short_name'] = shortName;
    data['name'] = name;
    data['logo'] = logo;
    data['code'] = code;
    data['bin'] = bin;
    return data;
  }

  String get getShortName => shortName ?? '';

  String get getName => name ?? '';

  String get getLogo => logo ?? '';
}
