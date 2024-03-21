import 'location_obj.dart';
import 'rating.dart';

class Shop {
  String? id;
  String? fullName;
  String? shopName;
  String? subdomain;
  String? phoneNumber;
  String? avatar;
  String? shopUrl;
  String? location;
  LocationObj? locationObj;
  String? shopOnline;
  String? shopOnlineText;
  String? henGiao;
  String? shopOpenTime;
  String? shopCloseTime;
  bool? follow;
  Rating? rating;
  String? createdAt;
  String? latitude;
  String? longitude;

  Shop({
    this.id,
    this.fullName,
    this.shopName,
    this.subdomain,
    this.phoneNumber,
    this.avatar,
    this.shopUrl,
    this.location,
    this.locationObj,
    this.shopOnline,
    this.shopOnlineText,
    this.henGiao,
    this.shopOpenTime,
    this.shopCloseTime,
    this.follow,
    this.rating,
    this.createdAt,
    this.latitude,
    this.longitude,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json['id'],
        fullName: json['fullName'],
        shopName: json['shop_name'],
        subdomain: json['subdomain'],
        phoneNumber: json['phone_number'],
        avatar: json['avatar'],
        shopUrl: json['shop_url'],
        location: json['location'],
        locationObj: json['location_obj'] == null ? null : LocationObj.fromJson(json['location_obj']!),
        shopOnline: json['shop_online'],
        shopOnlineText: json['shop_online_text'],
        henGiao: json['hen_giao'],
        shopOpenTime: json['shop_open_time'],
        shopCloseTime: json['shop_close_time'],
        follow: json['follow'],
        rating: json['rating'] == null ? null : Rating.fromJson(json['rating']),
        createdAt: json['created_at'],
        latitude: json['latitude'].toString(),
        longitude: json['longitude'].toString(),
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'fullName': fullName,
        'shop_name': shopName,
        'subdomain': subdomain,
        'phone_number': phoneNumber,
        'avatar': avatar,
        'shop_url': shopUrl,
        'location': location,
        'location_obj': locationObj?.toJson(),
        'shop_online': shopOnline,
        'shop_online_text': shopOnlineText,
        'hen_giao': henGiao,
        'shop_open_time': shopOpenTime,
        'shop_close_time': shopCloseTime,
        'follow': follow,
        'rating': rating?.toJson(),
        'created_at': createdAt,
        'latitude': latitude,
        'longitude': longitude,
      };

  Shop copyWith({
    String? id,
    String? fullName,
    String? shopName,
    String? subdomain,
    String? phoneNumber,
    String? avatar,
    String? shopUrl,
    String? location,
    LocationObj? locationObj,
    String? shopOnline,
    String? shopOnlineText,
    String? henGiao,
    String? shopOpenTime,
    String? shopCloseTime,
    bool? follow,
    Rating? rating,
    String? createdAt,
    String? latitude,
    String? longitude,
  }) {
    return Shop(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      shopName: shopName ?? this.shopName,
      subdomain: subdomain ?? this.subdomain,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      shopUrl: shopUrl ?? this.shopUrl,
      location: location ?? this.location,
      locationObj: locationObj ?? this.locationObj,
      shopOnline: shopOnline ?? this.shopOnline,
      shopOnlineText: shopOnlineText ?? this.shopOnlineText,
      henGiao: henGiao ?? this.henGiao,
      shopOpenTime: shopOpenTime ?? this.shopOpenTime,
      shopCloseTime: shopCloseTime ?? this.shopCloseTime,
      follow: follow ?? this.follow,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
