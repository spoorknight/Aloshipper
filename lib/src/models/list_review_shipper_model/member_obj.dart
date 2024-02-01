import '../shared_models/location_obj.dart';

class MemberObj {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? avatar;
  String? location;
  LocationObj? locationObj;
  String? createdAt;

  MemberObj({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.location,
    this.locationObj,
    this.createdAt,
  });

  factory MemberObj.fromJson(Map<String, dynamic> json) => MemberObj(
        id: json['id'] as String?,
        fullName: json['fullName'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['phone_number'] as String?,
        avatar: json['avatar'] as String?,
        location: json['location'] as String?,
        locationObj:
            json['location_obj'] == null ? null : LocationObj.fromJson(json['location_obj'] as Map<String, dynamic>),
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone_number': phoneNumber,
        'avatar': avatar,
        'location': location,
        'location_obj': locationObj?.toJson(),
        'created_at': createdAt,
      };
}
