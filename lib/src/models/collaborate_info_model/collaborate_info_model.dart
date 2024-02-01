import 'package:equatable/equatable.dart';

import 'item.dart';

class CollaborateInfoModel extends Equatable {
  final bool? status;
  final Item? item;

  const CollaborateInfoModel({this.status, this.item});

  factory CollaborateInfoModel.fromJson(Map<String, dynamic> json) {
    return CollaborateInfoModel(
      status: json['status'] as bool?,
      item: json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'item': item?.toJson(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, item];
}
