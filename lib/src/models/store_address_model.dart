class StoreAddress {
  StoreAddress({
    this.id,
    this.storeImage,
    this.storeName,
    this.storeManager,
    this.storePhone,
    this.storeAddress,
    this.userInit,
    this.userUpd,
    this.created,
    this.updated,
    this.image,
    this.status,
    this.storeTinh,
    this.storeQuan,
    this.storePhuong,
    this.storeLatitude,
    this.storeLongitude,
    this.nameTinh,
    this.nameQuan,
    this.namePhuong,
  });

  String? id;
  dynamic storeImage;
  String? storeName;
  dynamic storeManager;
  String? storePhone;
  String? storeAddress;
  String? userInit;
  String? userUpd;
  DateTime? created;
  DateTime? updated;
  String? image;
  String? status;
  String? storeTinh;
  String? storeQuan;
  String? storePhuong;
  String? storeLatitude;
  String? storeLongitude;
  String? nameTinh;
  String? nameQuan;
  String? namePhuong;

  factory StoreAddress.fromJson(Map<String, dynamic> json) => StoreAddress(
        id: json["ID"],
        storeImage: json["store_image"],
        storeName: json["store_name"],
        storeManager: json["store_manager"],
        storePhone: json["store_phone"],
        storeAddress: json["store_address"],
        userInit: json["user_init"],
        userUpd: json["user_upd"],
        created: DateTime.tryParse(json["created"] ?? ''),
        updated: DateTime.tryParse(json["updated"] ?? ''),
        image: json["image"],
        status: json["status"],
        storeTinh: json["store_tinh"],
        storeQuan: json["store_quan"],
        storePhuong: json["store_phuong"],
        storeLatitude: json["store_latitude"],
        storeLongitude: json["store_longitude"],
        nameTinh: json["name_tinh"],
        nameQuan: json["name_quan"],
        namePhuong: json["name_phuong"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "store_image": storeImage,
        "store_name": storeName,
        "store_manager": storeManager,
        "store_phone": storePhone,
        "store_address": storeAddress,
        "user_init": userInit,
        "user_upd": userUpd,
        "created": created,
        "updated": updated,
        "image": image,
        "status": status,
        "store_tinh": storeTinh,
        "store_quan": storeQuan,
        "store_phuong": storePhuong,
        "store_latitude": storeLatitude,
        "store_longitude": storeLongitude,
        "name_tinh": nameTinh,
        "name_quan": nameQuan,
        "name_phuong": namePhuong,
      };
}
