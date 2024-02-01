import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:intl/intl.dart';

class HistoryMissionResponse {
  bool? status;
  List<HistoryMissionModel>? data;
  String? page;
  int? perPage;

  HistoryMissionResponse({this.status, this.data, this.page, this.perPage});

  HistoryMissionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <HistoryMissionModel>[];
      json['data'].forEach((v) {
        data!.add(HistoryMissionModel.fromJson(v));
      });
    }
    page = json['page'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['perPage'] = perPage;
    return data;
  }

  int get getTotalItemInPerPage => perPage ?? 10;
}

class HistoryMissionModel {
  String? id;
  String? implementerId;
  String? rewardRecipientId;
  String? value;
  String? giftType;
  String? createdAt;
  String? updatedAt;
  String? isConverted;
  String? missionId;
  String? name;

  HistoryMissionModel({
    this.id,
    this.implementerId,
    this.rewardRecipientId,
    this.value,
    this.giftType,
    this.createdAt,
    this.updatedAt,
    this.isConverted,
    this.missionId,
    this.name,
  });

  HistoryMissionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    implementerId = json['implementer_id'];
    rewardRecipientId = json['reward_recipient_id'];
    value = json['value'];
    giftType = json['gift_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isConverted = json['is_converted'];
    missionId = json['mission_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['implementer_id'] = implementerId;
    data['reward_recipient_id'] = rewardRecipientId;
    data['value'] = value;
    data['gift_type'] = giftType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_converted'] = isConverted;
    data['mission_id'] = missionId;
    data['name'] = name;
    return data;
  }

  String get getName => name ?? '';

  String get getDate {
    try {
      return DateFormat('dd/MM/yyyy')
          .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(createdAt ?? ''));
    } catch (e) {
      return '';
    }
  }

  String get getTime {
    try {
      return DateFormat('HH:mm')
          .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(createdAt ?? ''));
    } catch (e) {
      return '';
    }
  }

  String get getValue => (value ?? '0').formatNumber;

  String get getUnit {
    switch (giftType) {
      case 'day':
        return 'ngày';
      default:
        return 'điểm';
    }
  }
}
