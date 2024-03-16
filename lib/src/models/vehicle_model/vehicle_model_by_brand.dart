/// status : true
/// mess : "get data successfully!"
/// data : [{"id":"1","vehicle_brand_id":"1","name":"SH","created_at":null,"updated_at":null},{"id":"2","vehicle_brand_id":"1","name":"Vision","created_at":null,"updated_at":null}]

class VehicleModelByBrand {
  VehicleModelByBrand({
      this.status, 
      this.mess, 
      this.data,});

  VehicleModelByBrand.fromJson(dynamic json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(VehicleModel.fromJson(v));
      });
    }
  }
  bool? status;
  String? mess;
  List<VehicleModel>? data;
VehicleModelByBrand copyWith({  bool? status,
  String? mess,
  List<VehicleModel>? data,
}) => VehicleModelByBrand(  status: status ?? this.status,
  mess: mess ?? this.mess,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['mess'] = mess;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// vehicle_brand_id : "1"
/// name : "SH"
/// created_at : null
/// updated_at : null

class VehicleModel {
  VehicleModel({
      this.id, 
      this.vehicleBrandId, 
      this.name, 
      this.createdAt, 
      this.updatedAt,});

  VehicleModel.fromJson(dynamic json) {
    id = json['id'];
    vehicleBrandId = json['vehicle_brand_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? vehicleBrandId;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;
VehicleModel copyWith({  String? id,
  String? vehicleBrandId,
  String? name,
  dynamic createdAt,
  dynamic updatedAt,
}) => VehicleModel(  id: id ?? this.id,
  vehicleBrandId: vehicleBrandId ?? this.vehicleBrandId,
  name: name ?? this.name,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['vehicle_brand_id'] = vehicleBrandId;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

  @override
  bool operator ==(covariant VehicleModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}