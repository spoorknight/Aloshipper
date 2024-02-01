import 'package:equatable/equatable.dart';

import 'order.dart';

class ListOrderModel extends Equatable {
  final bool? status;
  final int? numRows;
  final List<Order>? list;

  const ListOrderModel({this.status, this.numRows, this.list});

  factory ListOrderModel.fromJson(Map<String, dynamic> json) {
    return ListOrderModel(
      status: json['status'],
      numRows: json['num_rows'],
      list: json['list'] is String?
          ? []
          : (json['list'] as List<dynamic>?)?.map((e) => Order.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, Object?> toJson() => {
        'status': status,
        'num_rows': numRows,
        'list': list?.map((e) => e.toJson()).toList(),
      };

  ListOrderModel copyWith({
    bool? status,
    int? numRows,
    List<Order>? list,
  }) {
    return ListOrderModel(
      status: status ?? this.status,
      numRows: numRows ?? this.numRows,
      list: list ?? this.list,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, numRows, list];
}
