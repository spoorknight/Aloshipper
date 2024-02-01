class ContentShareModel {
  bool? status;
  String? mess;
  AppTypeSettings? shipperSettings;
  AppTypeSettings? shopSettings;

  ContentShareModel(
      {this.status, this.mess, this.shipperSettings, this.shopSettings});

  ContentShareModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    shipperSettings = json['shipper_settings'] != null
        ? AppTypeSettings.fromJson(json['shipper_settings'])
        : null;
    shopSettings = json['shop_settings'] != null
        ? AppTypeSettings.fromJson(json['shop_settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['mess'] = mess;
    if (shipperSettings != null) {
      data['shipper_settings'] = shipperSettings!.toJson();
    }
    if (shopSettings != null) {
      data['shop_settings'] = shopSettings!.toJson();
    }
    return data;
  }

  String? get getAppLinkSharing => shipperSettings?.link;

  String get getAppContentSharing => shipperSettings?.content ?? '';
}

class AppTypeSettings {
  String? id;
  String? content;
  String? link;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  AppTypeSettings(
      {this.id,
      this.content,
      this.link,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt});

  AppTypeSettings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    link = json['link'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['link'] = link;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
