import 'package:equatable/equatable.dart';

import '../shared_models/shop.dart';

class ListShopModel extends Equatable {
  final bool? status;
  final int? numRows;
  final List<Shop>? list;

  const ListShopModel({this.status, this.numRows, this.list});

  factory ListShopModel.fromJson(Map<String, dynamic> json) {
    return ListShopModel(
        status: json['status'] as bool?,
        numRows: json['num_rows'] as int?,
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => Shop.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'num_rows': numRows,
        'list': list?.map((e) => e.toJson()).toList(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, numRows, list];
}
