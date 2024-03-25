/// status : true
/// message : "Thành công!"
/// packages : [{"id":"287","title":"Gói ngày","number_of_days":"1","price":"5000","is_free":"0","is_shipper":"0","is_unlimited_time":"0","plan_order":"1","is_popular":"0","province_id":"75","description":["1 ngày sử dụng miễn phí"]}]
/// current_package_of_user : {"id":null,"title":"Gói mặc định","is_default":"1","plan_end_date":"2027-03-10 11:21:43"}
/// cannot_auto_renew_package_mess : "Gói mặc định không thể gia hạn tự động! vui lòng lựa chọn gói khác để tiếp tục!"
/// package_is_removed_mess : "Gói dịch vụ bạn đang sử dụng hiện đã bị xóa! vui lòng chọn mua gói khác để tiếp tục!"

class ListServiceNewModel {
  ListServiceNewModel({
      this.status, 
      this.message, 
      this.packages, 
      this.currentPackageOfUser, 
      this.cannotAutoRenewPackageMess, 
      this.packageIsRemovedMess,});

  ListServiceNewModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['packages'] != null) {
      packages = [];
      json['packages'].forEach((v) {
        packages?.add(Packages.fromJson(v));
      });
    }
    currentPackageOfUser = json['current_package_of_user'] != null ? CurrentPackageOfUser.fromJson(json['current_package_of_user']) : null;
    cannotAutoRenewPackageMess = json['cannot_auto_renew_package_mess'];
    packageIsRemovedMess = json['package_is_removed_mess'];
  }
  bool? status;
  String? message;
  List<Packages>? packages;
  CurrentPackageOfUser? currentPackageOfUser;
  String? cannotAutoRenewPackageMess;
  String? packageIsRemovedMess;
ListServiceNewModel copyWith({  bool? status,
  String? message,
  List<Packages>? packages,
  CurrentPackageOfUser? currentPackageOfUser,
  String? cannotAutoRenewPackageMess,
  String? packageIsRemovedMess,
}) => ListServiceNewModel(  status: status ?? this.status,
  message: message ?? this.message,
  packages: packages ?? this.packages,
  currentPackageOfUser: currentPackageOfUser ?? this.currentPackageOfUser,
  cannotAutoRenewPackageMess: cannotAutoRenewPackageMess ?? this.cannotAutoRenewPackageMess,
  packageIsRemovedMess: packageIsRemovedMess ?? this.packageIsRemovedMess,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (packages != null) {
      map['packages'] = packages?.map((v) => v.toJson()).toList();
    }
    if (currentPackageOfUser != null) {
      map['current_package_of_user'] = currentPackageOfUser?.toJson();
    }
    map['cannot_auto_renew_package_mess'] = cannotAutoRenewPackageMess;
    map['package_is_removed_mess'] = packageIsRemovedMess;
    return map;
  }

}

/// id : null
/// title : "Gói mặc định"
/// is_default : "1"
/// plan_end_date : "2027-03-10 11:21:43"

class CurrentPackageOfUser {
  CurrentPackageOfUser({
      this.id, 
      this.title, 
      this.isDefault, 
      this.isDeleted,
      this.planEndDate,});

  CurrentPackageOfUser.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    isDefault = json['is_default'];
    isDeleted = json['is_deleted'];
    planEndDate = json['plan_end_date'];
  }
  dynamic id;
  String? title;
  String? isDefault;
  String? isDeleted;
  String? planEndDate;
CurrentPackageOfUser copyWith({  dynamic id,
  String? title,
  String? isDefault,
  String? isDeleted,
  String? planEndDate,
}) => CurrentPackageOfUser(  id: id ?? this.id,
  title: title ?? this.title,
  isDefault: isDefault ?? this.isDefault,
  isDeleted: isDeleted ?? this.isDeleted,
  planEndDate: planEndDate ?? this.planEndDate,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['is_default'] = isDefault;
    map['is_deleted'] = isDeleted;
    map['plan_end_date'] = planEndDate;
    return map;
  }

}

/// id : "287"
/// title : "Gói ngày"
/// number_of_days : "1"
/// price : "5000"
/// is_free : "0"
/// is_shipper : "0"
/// is_unlimited_time : "0"
/// plan_order : "1"
/// is_popular : "0"
/// province_id : "75"
/// description : ["1 ngày sử dụng miễn phí"]

class Packages {
  Packages({
      this.id, 
      this.title, 
      this.numberOfDays, 
      this.price, 
      this.isFree, 
      this.isShipper, 
      this.isUnlimitedTime, 
      this.planOrder, 
      this.isPopular, 
      this.provinceId, 
      this.description,});

  Packages.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    numberOfDays = json['number_of_days'];
    price = json['price'];
    isFree = json['is_free'];
    isShipper = json['is_shipper'];
    isUnlimitedTime = json['is_unlimited_time'];
    planOrder = json['plan_order'];
    isPopular = json['is_popular'];
    provinceId = json['province_id'];
    description = json['description'] != null ? json['description'].cast<String>() : [];
  }
  String? id;
  String? title;
  String? numberOfDays;
  String? price;
  String? isFree;
  String? isShipper;
  String? isUnlimitedTime;
  String? planOrder;
  String? isPopular;
  String? provinceId;
  List<String>? description;
Packages copyWith({  String? id,
  String? title,
  String? numberOfDays,
  String? price,
  String? isFree,
  String? isShipper,
  String? isUnlimitedTime,
  String? planOrder,
  String? isPopular,
  String? provinceId,
  List<String>? description,
}) => Packages(  id: id ?? this.id,
  title: title ?? this.title,
  numberOfDays: numberOfDays ?? this.numberOfDays,
  price: price ?? this.price,
  isFree: isFree ?? this.isFree,
  isShipper: isShipper ?? this.isShipper,
  isUnlimitedTime: isUnlimitedTime ?? this.isUnlimitedTime,
  planOrder: planOrder ?? this.planOrder,
  isPopular: isPopular ?? this.isPopular,
  provinceId: provinceId ?? this.provinceId,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['number_of_days'] = numberOfDays;
    map['price'] = price;
    map['is_free'] = isFree;
    map['is_shipper'] = isShipper;
    map['is_unlimited_time'] = isUnlimitedTime;
    map['plan_order'] = planOrder;
    map['is_popular'] = isPopular;
    map['province_id'] = provinceId;
    map['description'] = description;
    return map;
  }

  List<String> get getListPlan => description ?? [];

  String get getTitle => title ?? '';

  double get getPrice => double.parse(price ?? '0');
}