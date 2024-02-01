class NapTienModel {
  NapTienModel({
    this.status,
    this.idNaptien,
    this.url,
    this.item,
    this.mess,
  });

  bool? status;
  int? idNaptien;
  String? url;
  String? item;
  String? mess;

  factory NapTienModel.fromJson(Map<String, dynamic> json) => NapTienModel(
        status: json["status"],
        idNaptien: json["id_naptien"],
        url: json["url"],
        item: json["item"],
        mess: json["mess"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id_naptien": idNaptien,
        "url": url,
      };
}
