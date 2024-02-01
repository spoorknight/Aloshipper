import 'package:equatable/equatable.dart';

import 'address_model.dart';

class ListAddressModel extends Equatable {
  const ListAddressModel({
    this.status,
    this.active,
    this.item,
  });

  final bool? status;
  final String? active;
  final List<AddressModel?>? item;

  factory ListAddressModel.fromJson(Map<String, dynamic> json) =>
      ListAddressModel(
        status: json["status"],
        active: json["active"],
        item: json["item"] == null
            ? []
            : List<AddressModel?>.from(
                json["item"]!.map((x) => AddressModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "active": active,
        "item": item == null
            ? []
            : List<dynamic>.from(item!.map((x) => x!.toJson())),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      status,
      active,
      item,
    ];
  }
}
