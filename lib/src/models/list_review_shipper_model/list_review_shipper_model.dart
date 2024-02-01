import 'review_shippeer_model.dart';

class ListReviewShipperModel {
  bool? status;
  int? numRows;
  List<ReviewShipperModel>? list;

  ListReviewShipperModel({this.status, this.numRows, this.list});

  factory ListReviewShipperModel.fromJson(Map<String, dynamic> json) {
    return ListReviewShipperModel(
      status: json['status'] as bool?,
      numRows: json['num_rows'] as int?,
      list:
          (json['list'] as List<dynamic>?)?.map((e) => ReviewShipperModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'num_rows': numRows,
        'list': list?.map((e) => e.toJson()).toList(),
      };
}
