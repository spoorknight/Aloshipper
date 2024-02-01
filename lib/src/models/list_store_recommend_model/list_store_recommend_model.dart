class ListStoreRecommendModel {
  ListStoreRecommendModel({
    this.status,
    this.numRows,
    this.list,
  });

  bool? status;
  int? numRows;
  List<StoreRecommendModel>? list;

  factory ListStoreRecommendModel.fromJson(Map<String, dynamic> json) =>
      ListStoreRecommendModel(
        status: json["status"],
        numRows: json["num_rows"],
        list: json["list"] == null
            ? []
            : List<StoreRecommendModel>.from(
                json["list"]!.map((x) => StoreRecommendModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "num_rows": numRows,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class StoreRecommendModel {
  StoreRecommendModel({
    this.id,
    this.fullName,
    this.shopName,
    this.phoneNumber,
    this.shopUrl,
    this.statusText,
    this.totalHoahong,
    this.createdAt,
    this.giahanAt,
    this.lastPayment,
  });

  String? id;
  String? fullName;
  String? shopName;
  String? phoneNumber;
  String? shopUrl;
  String? statusText;
  int? totalHoahong;
  String? createdAt;
  String? giahanAt;
  String? lastPayment;

  factory StoreRecommendModel.fromJson(Map<String, dynamic> json) =>
      StoreRecommendModel(
        id: json["id"],
        fullName: json["fullName"],
        shopName: json["shop_name"],
        phoneNumber: json["phone_number"],
        shopUrl: json["shop_url"],
        statusText: json["status_text"],
        totalHoahong: json["total_hoahong"],
        createdAt: json["created_at"],
        giahanAt: json["giahan_at"],
        lastPayment: json["last_payment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "shop_name": shopName,
        "phone_number": phoneNumber,
        "shop_url": shopUrl,
        "status_text": statusText,
        "total_hoahong": totalHoahong,
        "created_at": createdAt,
        "giahan_at": giahanAt,
        "last_payment": lastPayment,
      };
}
