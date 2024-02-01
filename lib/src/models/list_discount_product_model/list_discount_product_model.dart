import 'discount_product_model.dart';

class ListDiscountProductModel {
  bool? status;
  int? numRows;
  List<DiscountProductModel>? list;

  ListDiscountProductModel({this.status, this.numRows, this.list});

  @override
  String toString() {
    return 'ListDiscountProduct(status: $status, numRows: $numRows, list: $list)';
  }

  factory ListDiscountProductModel.fromJson(Map<String, dynamic> json) {
    return ListDiscountProductModel(
      status: json['status'] as bool?,
      numRows: json['num_rows'] as int?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => DiscountProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'num_rows': numRows,
        'list': list?.map((e) => e.toJson()).toList(),
      };
}
