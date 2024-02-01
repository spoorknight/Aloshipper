// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.status,
    this.shipperId,
    this.mess,
    this.item,
  });

  bool? status;
  String? shipperId;
  String? mess;
  String? item;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        shipperId: json["shipper_id"],
        mess: json["mess"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "shipper_id": shipperId,
        "mess": mess,
      };
}
