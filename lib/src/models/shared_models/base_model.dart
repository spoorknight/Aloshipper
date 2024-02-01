import 'package:equatable/equatable.dart';

class BaseModel extends Equatable {
  final bool? status;
  final String? mess;
  final String? item;

  const BaseModel({
    this.status,
    this.mess,
    this.item,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        status: json['status'] as bool?,
        mess: json['mess'] as String?,
        item: json['item'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'mess': mess,
        'item': item,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, mess, item];
}
