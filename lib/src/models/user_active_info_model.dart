class UserInfoActiveModel {
  bool? status;
  String? mess;
  Data? data;

  UserInfoActiveModel({this.status, this.mess, this.data});

  UserInfoActiveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['mess'] = mess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  int get getTotalHoursShipper => data?.totalHoursShipper ?? 0;

  int get getTotalHoursSetting => data?.totalHoursSetting ?? 0;

  int get getTotalHoursNeedOnline => data?.totalHoursNeedOnline ?? 0;

  String get getStartDate => data?.startDate ?? '';

  String get getEndDate => data?.endDate ?? '';

  bool get isEnoughTime => getTotalHoursSetting <= getTotalHoursShipper;
}

class Data {
  int? totalHoursSetting;
  int? totalHoursShipper;
  String? startDate;
  String? endDate;
  int? totalHoursNeedOnline;

  Data(
      {this.totalHoursSetting,
      this.totalHoursShipper,
      this.startDate,
      this.endDate,
      this.totalHoursNeedOnline});

  Data.fromJson(Map<String, dynamic> json) {
    totalHoursSetting = json['total_hours_setting'];
    totalHoursShipper = json['total_hours_shipper'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalHoursNeedOnline = json['total_hours_need_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_hours_setting'] = totalHoursSetting;
    data['total_hours_shipper'] = totalHoursShipper;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['total_hours_need_online'] = totalHoursNeedOnline;
    return data;
  }
}
