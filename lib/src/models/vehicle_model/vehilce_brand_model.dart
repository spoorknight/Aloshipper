/// status : true
/// mess : "get data successfully!"
/// data : [{"id":"1","name":"Honda","created_at":null,"updated_at":null},{"id":"2","name":"Yamaha","created_at":null,"updated_at":null},{"id":"3","name":"Suzuki","created_at":null,"updated_at":null},{"id":"6","name":"Audi","created_at":null,"updated_at":null},{"id":"7","name":"Mercedes-Benz","created_at":null,"updated_at":null}]

class VehilceBrandResponse {
  VehilceBrandResponse({
      this.status, 
      this.mess, 
      this.data,});

  VehilceBrandResponse.fromJson(dynamic json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(VehicleBrand.fromJson(v));
      });
    }
  }
  bool? status;
  String? mess;
  List<VehicleBrand>? data;
VehilceBrandResponse copyWith({  bool? status,
  String? mess,
  List<VehicleBrand>? data,
}) => VehilceBrandResponse(  status: status ?? this.status,
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
/// name : "Honda"
/// created_at : null
/// updated_at : null

class VehicleBrand {
  VehicleBrand({
      this.id, 
      this.name, 
      this.createdAt, 
      this.updatedAt,});

  VehicleBrand.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;
VehicleBrand copyWith({  String? id,
  String? name,
  dynamic createdAt,
  dynamic updatedAt,
}) => VehicleBrand(  id: id ?? this.id,
  name: name ?? this.name,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

  @override
  bool operator ==(covariant VehicleBrand other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}