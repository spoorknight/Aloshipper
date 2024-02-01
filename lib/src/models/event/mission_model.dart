import 'dart:io';

import 'package:intl/intl.dart';

import '../../utils/app_enum.dart';
import '../../utils/utils.dart';

class MissionResponse {
  bool? status;
  String? mess;
  List<MissionModel>? data;
  String? missionTitle;
  String? shareTitle;

  String? admobAlotodayIos;
  String? admobAlotodayAndroid;
  String? admobAloshipperIos;
  String? admobAloshipperAndroid;
  String? admobAlostoreIos;
  String? admobAlostoreAndroid;

  MissionResponse({
    this.status,
    this.mess,
    this.data,
    this.missionTitle,
    this.shareTitle,
    this.admobAlotodayIos,
    this.admobAlotodayAndroid,
    this.admobAloshipperIos,
    this.admobAloshipperAndroid,
    this.admobAlostoreIos,
    this.admobAlostoreAndroid,
  });

  MissionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    missionTitle = json['mission_title'];
    shareTitle = json['share_title'];
    admobAlotodayIos = json['admob_alotoday_ios'];
    admobAlotodayAndroid = json['admob_alotoday_android'];
    admobAloshipperIos = json['admob_aloshipper_ios'];
    admobAloshipperAndroid = json['admob_aloshipper_android'];
    admobAlostoreIos = json['admob_alostore_ios'];
    admobAlostoreAndroid = json['admob_alostore_android'];
    if (json['data'] != null) {
      data = <MissionModel>[];
      json['data'].forEach((v) {
        data!.add(MissionModel.fromJson(v));
      });
    }
  }

  String get getInitAdsKey {
    if (Platform.isAndroid) {
      return admobAloshipperAndroid ?? '';
    } else if (Platform.isIOS) {
      return admobAloshipperIos ?? '';
    } else {
      return '';
    }
  }
}

class MissionModel {
  String? id;
  String? name;
  String? value;
  String? applyFor;
  String? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? pointValue;
  String? description;
  String? frequencyPerDay;
  String? isUnlimitedTimes;
  String? missionKey;
  bool? isDisable;
  String? executionCount;
  String? beginAt;
  String? endAt;
  String? tempPoints;
  String? totalRegistered;
  String? totalCompletedOrders;
  String? receivedPoints;
  String? shortDescription;

  ConfigWatchAds? numberOfAdViewsPerNMinutes;
  ConfigWatchAds? canWatchAdsAfterNMinutes;
  ChildMissions? childMissions;

  MissionModel({
    this.id,
    this.name,
    this.value,
    this.applyFor,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.pointValue,
    this.description,
    this.frequencyPerDay,
    this.isUnlimitedTimes,
    this.missionKey,
    this.isDisable,
    this.executionCount,
    this.beginAt,
    this.endAt,
    this.tempPoints,
    this.totalRegistered,
    this.totalCompletedOrders,
    this.receivedPoints,
    this.childMissions,
    this.numberOfAdViewsPerNMinutes,
    this.canWatchAdsAfterNMinutes,
    this.shortDescription,
  });

  MissionModel.fromJson(Map<String, dynamic> json) {
    id = Utils().convertToString(json['id']);
    name = Utils().convertToString(json['name']);
    value = Utils().convertToString(json['value']);
    applyFor = Utils().convertToString(json['apply_for']);
    isDeleted = Utils().convertToString(json['is_deleted']);
    createdAt = Utils().convertToString(json['created_at']);
    updatedAt = Utils().convertToString(json['updated_at']);
    pointValue = Utils().convertToString(json['point_value']);
    description = Utils().convertToString(json['description']);
    frequencyPerDay = Utils().convertToString(json['frequency_per_day']);
    isUnlimitedTimes = Utils().convertToString(json['is_unlimited_times']);
    missionKey = Utils().convertToString(json['mission_key']);
    isDisable = json['is_disable'];
    executionCount = Utils().convertToString(json['execution_count']);
    beginAt = Utils().convertToString(json['begin_at']);
    endAt = Utils().convertToString(json['end_at']);
    tempPoints = Utils().convertToString(json['temp_points']);
    shortDescription = Utils().convertToString(json['short_description']);
    totalRegistered = Utils().convertToString(json['totalRegistered']);
    totalCompletedOrders =
        Utils().convertToString(json['totalCompletedOrders']);
    receivedPoints = Utils().convertToString(json['received_points']);

    childMissions = json['child_missions'] != null
        ? ChildMissions.fromJson(json['child_missions'])
        : null;
    canWatchAdsAfterNMinutes = json['can_watch_ads_after_n_minutes'] != null
        ? ConfigWatchAds.fromJson(json['can_watch_ads_after_n_minutes'])
        : null;
    numberOfAdViewsPerNMinutes =
        json['number_of_ad_views_per_n_minutes'] != null
            ? ConfigWatchAds.fromJson(json['number_of_ad_views_per_n_minutes'])
            : null;
  }

  double get getPointValue => double.tryParse(pointValue ?? '0') ?? 0;

  double get getDayValue => double.tryParse(value ?? '0') ?? 0;

  int get checkNumDayNeedToDone {
    try {
      return (int.tryParse(frequencyPerDay ?? '0') ?? 0) -
          (int.tryParse(executionCount ?? '0') ?? 0);
    } catch (e) {
      return 0;
    }
  }

  bool get isReceiveMission => getTotalHarvest > 0;

  bool get checkIsUnlimitedTimes => (isUnlimitedTimes ?? '0') == '1';

  bool get checkDisableButton {
    if (isReceiveMission) {
      return true;
    }
    if (checkIsUnlimitedTimes) {
      return false;
    } else {
      return checkNumDayNeedToDone == 0;
    }
  }

  MissionType get getMissionType {
    switch (missionKey) {
      case 'AD_VIEWS':
        return MissionType.adViews;
      case 'SHARE':
        return MissionType.share;
      case 'REFER_FRIEND':
        return MissionType.referFriend;
      case 'CHECK_IN':
        return MissionType.checkIn;
      default:
        return MissionType.none;
    }
  }

  double get getTotalHarvest {
    // if (childMissions != null) {
    //   if (childMissions!.isCompleteAll) {
    //     return childMissions!.totalPoint;
    //   }
    // }
    return (double.tryParse(receivedPoints ?? '0') ?? 0);
  }

  String get getBeginAt {
    if (beginAt == null) return '';

    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    String inputDateTimeString = beginAt!;
    DateTime inputDateTime = DateTime.parse(inputDateTimeString);

    return formatter.format(inputDateTime);
  }

  String get getEndAt {
    if (endAt == null) return '';

    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    String inputDateTimeString = endAt!;
    DateTime inputDateTime = DateTime.parse(inputDateTimeString);

    return formatter.format(inputDateTime);
  }

  String get getShortDescription =>
      shortDescription ??
      'Xem một quảng cáo ngắn để nhận thêm thời gian sử dụng\nNâng cấp lên các gói dịch vụ để trải nghiệm không giới hạn';
}

class ChildMissions {
  Registers? registers;
  Registers? completedOrders;
  Registers? adViews;

  ChildMissions({this.registers, this.completedOrders, this.adViews});

  ChildMissions.fromJson(Map<String, dynamic> json) {
    registers = json['registers'] != null
        ? Registers.fromJson(json['registers'])
        : null;
    completedOrders = json['completed_orders'] != null
        ? Registers.fromJson(json['completed_orders'])
        : null;
    adViews =
        json['ad_views'] != null ? Registers.fromJson(json['ad_views']) : null;
  }

  bool get isCompleteAll {
    return (adViews?.isCompleted == true &&
        completedOrders?.isCompleted == true &&
        registers?.isCompleted == true);
  }

  double get totalPoint {
    double adViewsPoint = double.tryParse(adViews?.points ?? '0') ?? 0;
    double completedOrdersPoint =
        double.tryParse(completedOrders?.points ?? '0') ?? 0;
    double registersPoint = double.tryParse(registers?.points ?? '0') ?? 0;
    return adViewsPoint + completedOrdersPoint + registersPoint;
  }
}

class Registers {
  String? quantity;
  String? title;
  String? points;
  bool? isCompleted;

  Registers({this.quantity, this.title, this.points, this.isCompleted});

  Registers.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    title = json['title'];
    points = json['points'];
    isCompleted = json['is_completed'];
  }
}

class ConfigWatchAds {
  String? id;
  String? key;
  String? valueNumber;
  String? valueString;
  String? valueTimestamp;
  String? note;
  String? createdAt;
  String? updatedAt;

  ConfigWatchAds({
    this.id,
    this.key,
    this.valueNumber,
    this.valueString,
    this.valueTimestamp,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  ConfigWatchAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    valueNumber = json['value_number'];
    valueString = json['value_string'];
    valueTimestamp = json['value_timestamp'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['value_number'] = valueNumber;
    data['value_string'] = valueString;
    data['value_timestamp'] = valueTimestamp;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
