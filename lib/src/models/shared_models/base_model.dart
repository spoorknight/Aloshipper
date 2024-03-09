import 'package:equatable/equatable.dart';

class BaseModel extends Equatable {
  final bool? status;
  final String? mess;
  final String? item;
  final String? id; // id của shop khi chuyển từ subdomain
  final bool? exceededTimes;
  final String? hotline;

  const BaseModel({
    this.status,
    this.mess,
    this.item,
    this.id,
    this.exceededTimes,
    this.hotline,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
    status: json['status'] as bool?,
    mess: json['mess'] as String?,
    item: json['item'] as String?,
    id: json['id'] as String?,
    hotline: json['hotline'] as String?,
    exceededTimes: json['exceeded_times'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'mess': mess,
    'item': item,
    'id': id,
  };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, mess, item, id];

  bool get checkStatusSuccess => status == true;

  String get getMess => mess ?? item ?? '';
}
