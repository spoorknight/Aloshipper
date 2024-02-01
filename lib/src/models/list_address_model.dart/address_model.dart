class AddressModel {
  final String? id;
  final String? name;
  final String? type;
  final String? continentCode;
  final String? status;
  final String? countryId;
  final String? stateId;

  const AddressModel({
    this.id,
    this.name,
    this.type,
    this.continentCode,
    this.status,
    this.countryId,
    this.stateId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
        continentCode: json['continent_code'] as String?,
        status: json['status'] as String?,
        countryId: json['country_id'] as String?,
        stateId: json['state_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'continent_code': continentCode,
        'status': status,
        'country_id': countryId,
        'state_id': stateId,
      };

  AddressModel copyWith({
    String? id,
    String? name,
    String? type,
    String? continentCode,
    String? status,
    String? countryId,
    String? stateId,
  }) {
    return AddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      continentCode: continentCode ?? this.continentCode,
      status: status ?? this.status,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
    );
  }

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

class AddressSelected {
  AddressModel? province;
  AddressModel? district;
  AddressModel? commune;
  String? detailAddr;
  String? fullAddr;

  AddressSelected({
    this.province,
    this.district,
    this.commune,
    this.detailAddr,
    this.fullAddr,
  });
  @override
  String toString() {
    return 'AddressSelected(province: $province, district: $district, commune: $commune, detailAddr: $detailAddr, fullAddr: $fullAddr)';
  }

  @override
  bool operator ==(covariant AddressSelected other) {
    if (identical(this, other)) return true;

    return other.province == province &&
        other.district == district &&
        other.commune == commune &&
        other.detailAddr == detailAddr &&
        other.fullAddr == fullAddr;
  }

  @override
  int get hashCode {
    return province.hashCode ^
        district.hashCode ^
        commune.hashCode ^
        detailAddr.hashCode ^
        fullAddr.hashCode;
  }
}
