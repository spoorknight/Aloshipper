import '../shared_models/location_obj.dart';
import '../shared_models/rating.dart';

class ShipperModel {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? loaixe;
  String? loaixeText;
  String? biensoxe;
  int? phigiaohang;
  int? phigoixe;
  String? avatar;
  String? location;
  LocationObj? locationObj;
  String? shopOnline;
  String? shopOnlineText;
  Rating? rating;
  String? createdAt;
 

  ShipperModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.loaixe,
    this.loaixeText,
    this.biensoxe,
    this.phigiaohang,
    this.phigoixe,
    this.avatar,
    this.location,
    this.locationObj,
    this.shopOnline,
    this.shopOnlineText,
    this.rating,
    this.createdAt,
   
  });

  factory ShipperModel.fromJson(Map<String, dynamic> json) => ShipperModel(
        id: json['id'],
        fullName: json['fullName'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        loaixe: json['loaixe'],
        loaixeText: json['loaixe_text'],
        biensoxe: json['biensoxe'],
        phigiaohang: json['phigiaohang'],
        phigoixe: json['phigoixe'],
        avatar: json['avatar'],
        location: json['location'],
        locationObj: json['location_obj'] == null ? null : LocationObj.fromJson(json['location_obj']),
        shopOnline: json['shop_online'],
        shopOnlineText: json['shop_online_text'],
        rating: json['rating'] == null ? null : Rating.fromJson(json['rating']),
        createdAt: json['created_at'],
        
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone_number': phoneNumber,
        'loaixe': loaixe,
        'loaixe_text': loaixeText,
        'biensoxe': biensoxe,
        'phigiaohang': phigiaohang,
        'phigoixe': phigoixe,
        'avatar': avatar,
        'location': location,
        'location_obj': locationObj?.toJson(),
        'shop_online': shopOnline,
        'shop_online_text': shopOnlineText,
        'rating': rating?.toJson(),
        'created_at': createdAt,
       
      };
}
