class ListServiceModel {
  ListServiceModel({
    this.numRows,
    this.list,
  });

  dynamic numRows;
  List<ServiceModel>? list;

  factory ListServiceModel.fromJson(Map<String, dynamic> json) =>
      ListServiceModel(
        numRows: json["num_rows"],
        list: json["list"] == null
            ? []
            : List<ServiceModel>.from(
                json["list"]!.map((x) => ServiceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num_rows": numRows,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class ServiceModel {
  ServiceModel({
    this.id,
    this.numberOfDays,
    this.price,
    this.isFree,
    this.isUnlimitedTime,
    this.planOrder,
    this.isPopular,
    this.isShipper,
    this.title,
    this.planFeatures,
  });

  String? id;
  String? numberOfDays;
  double? price;
  String? isFree;
  String? isUnlimitedTime;
  String? planOrder;
  String? isPopular;
  String? isShipper;
  String? title;
  List<String>? planFeatures;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        numberOfDays: json["number_of_days"],
        price: double.tryParse((json["price"] ?? '0').toString()) ?? 0,
        isFree: json["is_free"],
        isUnlimitedTime: json["is_unlimited_time"],
        planOrder: json["plan_order"],
        isPopular: json["is_popular"],
        isShipper: json["is_shipper"],
        title: json["title"],
        planFeatures: json["plan_features"] == null
            ? []
            : List<String>.from(json["plan_features"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number_of_days": numberOfDays,
        "price": price,
        "is_free": isFree,
        "is_unlimited_time": isUnlimitedTime,
        "plan_order": planOrder,
        "is_popular": isPopular,
        "is_shipper": isShipper,
        "title": title,
        "plan_features": planFeatures == null
            ? []
            : List<dynamic>.from(planFeatures!.map((x) => x)),
      };

  List<String> get getListPlan => planFeatures ?? [];

  String get getTitle => title ?? '';

  double get getPrice => price ?? 0;
}
