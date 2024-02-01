import '../../utils/utils.dart';

class CustomerPointInfoResponse {
  bool? status;
  String? mess;
  CustomerPointInfoModel? data;

  CustomerPointInfoResponse({this.status, this.mess, this.data});

  CustomerPointInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    data = json['data'] != null
        ? CustomerPointInfoModel.fromJson(json['data'])
        : null;
  }
}

class CustomerPointInfoModel {
  String? points;
  String? equivalentAmountInVND;
  String? userCurrentPoints;
  String? userPointsToMoney;
  String? userConvertedPoints;
  String? userConvertedMoney;
  String? equivalentPointToHours;
  String? pointToHoursConfigText;
  String? pointToHoursConfig;

  CustomerPointInfoModel({
    this.points,
    this.equivalentAmountInVND,
    this.userCurrentPoints,
    this.userPointsToMoney,
    this.userConvertedPoints,
    this.userConvertedMoney,
    this.equivalentPointToHours,
    this.pointToHoursConfigText,
    this.pointToHoursConfig,
  });

  CustomerPointInfoModel.fromJson(Map<String, dynamic> json) {
    points = Utils().convertToString(json['points']);
    equivalentAmountInVND =
        Utils().convertToString(json['equivalentAmountInVND']);
    userCurrentPoints = Utils().convertToString(json['userCurrentPoints']);
    userPointsToMoney = Utils().convertToString(json['userPointsToMoney']);
    userConvertedPoints = Utils().convertToString(json['userConvertedPoints']);
    userConvertedMoney = Utils().convertToString(json['userConvertedMoney']);
    equivalentPointToHours =
        Utils().convertToString(json['equivalentPointToHours']);
    pointToHoursConfigText =
        Utils().convertToString(json['pointToHoursConfigText']);
    pointToHoursConfig = Utils().convertToString(json['pointToHoursConfig']);
  }

  int get getPoint => int.tryParse(points ?? '0') ?? 0;

  double get getUserCurrentPoints =>
      double.tryParse(userCurrentPoints ?? '0') ?? 0;

  double get getEquivalentAmountInVND =>
      double.tryParse(equivalentAmountInVND ?? '0') ?? 0;

  double get getPointToHoursConfig =>
      double.tryParse(pointToHoursConfig ?? '0') ?? 0;

  double get getEquivalentPointToHours =>
      double.tryParse(equivalentPointToHours ?? '0') ?? 0;

  double get getRatioPointToChangeMoney {
    return getEquivalentAmountInVND / (getPoint > 0 ? getPoint : 1);
  }

  double get getRatioPointToChangeDay {
    return getPointToHoursConfig /
        (getEquivalentPointToHours > 0 ? getEquivalentPointToHours : 1);
  }
}
