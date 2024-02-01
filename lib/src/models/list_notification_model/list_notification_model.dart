import 'package:equatable/equatable.dart';

import 'notification_model.dart';

class ListNotificationModel extends Equatable {
  final bool? status;
  final int? numRows;
  final List<NotificationModel>? list;

  const ListNotificationModel({this.status, this.numRows, this.list});

  factory ListNotificationModel.fromJson(Map<String, dynamic> json) {
    try {
      return ListNotificationModel(
        status: json['status'] as bool?,
        numRows: json['num_rows'] as int?,
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return ListNotificationModel(
        status: json['status'] as bool?,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'num_rows': numRows,
        'list': list?.map((e) => e.toJson()).toList(),
      };

  ListNotificationModel copyWith({
    bool? status,
    int? numRows,
    List<NotificationModel>? list,
  }) {
    return ListNotificationModel(
      status: status ?? this.status,
      numRows: numRows ?? this.numRows,
      list: list ?? this.list,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<dynamic> get props => [status, numRows, list];
}
