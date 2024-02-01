import 'package:equatable/equatable.dart';

import 'bought_customer.dart';

class ListBoughtCustomerModel extends Equatable {
  final bool? status;
  final int? numRows;
  final List<BoughtCustomerModel>? list;

  const ListBoughtCustomerModel({this.status, this.numRows, this.list});

  factory ListBoughtCustomerModel.fromJson(Map<String, dynamic> json) {
    return ListBoughtCustomerModel(
      status: json['status'] as bool?,
      numRows: json['num_rows'] as int?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => BoughtCustomerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
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
