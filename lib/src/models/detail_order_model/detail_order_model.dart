import 'package:equatable/equatable.dart';

import 'item.dart';

class DetailOrderModel extends Equatable {
  final bool? status;
  final String? mess;
  final Item? item;

  const DetailOrderModel({this.status, this.mess, this.item});

  factory DetailOrderModel.fromJson(Map<String, Object?> json) {
    return DetailOrderModel(
      status: json['status'] as bool?,
      mess: json['mess'] as String?,
      item: json['item'] == null
          ? null
          : Item.fromJson(json['item']! as Map<String, Object?>),
    );
  }

  Map<String, Object?> toJson() => {
        'status': status,
        'item': item?.toJson(),
      };

  DetailOrderModel copyWith({
    bool? status,
    Item? item,
  }) {
    return DetailOrderModel(
      status: status ?? this.status,
      item: item ?? this.item,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, item];
}
