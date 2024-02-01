import 'package:equatable/equatable.dart';

class Shipping extends Equatable {
  final String? id;
  final String? orderId;
  final String? shippingFirstName;
  final String? shippingLastName;
  final String? shippingEmail;
  final String? shippingPhoneNumber;
  final String? shippingAddress;
  final String? shippingCountry;
  final String? shippingState;
  final String? shippingCity;
  final String? shippingZipCode;
  final String? billingFirstName;
  final String? billingLastName;
  final String? billingEmail;
  final String? billingPhoneNumber;
  final String? billingAddress;
  final String? billingCountry;
  final String? billingState;
  final String? billingCity;
  final String? billingZipCode;
  final String? shippingAddressId;
  final String? fullAddress;

  final String? fullname;
  final String? phoneNumber;
  final String? fromAddress;
  final String? fromCountry;
  final String? fromState;
  final String? fromCity;
  final String? toAddress;
  final String? toCountry;
  final String? toState;
  final String? toCity;
  final double? latitude;
  final double? longitude;
  final double? fromLatitude;
  final double? fromLongitude;
  final double? toLatitude;
  final double? toLongitude;

  const Shipping({
    this.id,
    this.orderId,
    this.shippingFirstName,
    this.shippingLastName,
    this.shippingEmail,
    this.shippingPhoneNumber,
    this.shippingAddress,
    this.shippingCountry,
    this.shippingState,
    this.shippingCity,
    this.shippingZipCode,
    this.billingFirstName,
    this.billingLastName,
    this.billingEmail,
    this.billingPhoneNumber,
    this.billingAddress,
    this.billingCountry,
    this.billingState,
    this.billingCity,
    this.billingZipCode,
    this.shippingAddressId,
    this.fullname,
    this.phoneNumber,
    this.fromAddress,
    this.fromCountry,
    this.fromState,
    this.fromCity,
    this.toAddress,
    this.toCountry,
    this.toState,
    this.toCity,
    this.latitude,
    this.longitude,
    this.fromLatitude,
    this.fromLongitude,
    this.toLatitude,
    this.toLongitude,
    this.fullAddress,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        id: json['id'],
        fullAddress: json['full_address'],
        orderId: json['order_id'],
        shippingFirstName: json['shipping_first_name'],
        shippingLastName: json['shipping_last_name'],
        shippingEmail: json['shipping_email'],
        shippingPhoneNumber: json['shipping_phone_number'],
        shippingAddress: json['shipping_address'],
        shippingCountry: json['shipping_country'],
        shippingState: json['shipping_state'],
        shippingCity: json['shipping_city'],
        shippingZipCode: json['shipping_zip_code'],
        billingFirstName: json['billing_first_name'],
        billingLastName: json['billing_last_name'],
        billingEmail: json['billing_email'],
        billingPhoneNumber: json['billing_phone_number'],
        billingAddress: json['billing_address'],
        billingCountry: json['billing_country'],
        billingState: json['billing_state'],
        billingCity: json['billing_city'],
        billingZipCode: json['billing_zip_code'],
        shippingAddressId: json['shipping_address_id'],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        fromAddress: json["from_address"],
        fromCountry: json["from_country"],
        fromState: json["from_state"],
        fromCity: json["from_city"],
        toAddress: json["to_address"],
        toCountry: json["to_country"],
        toState: json["to_state"],
        toCity: json["to_city"],
        latitude: double.tryParse(json["latitude"].toString()),
        longitude: double.tryParse(json["longitude"].toString()),
        fromLatitude: double.tryParse(json['from_latitude'].toString()),
        fromLongitude: double.tryParse(json['from_longitude'].toString()),
        toLatitude: double.tryParse(json['to_latitude'].toString()),
        toLongitude: double.tryParse(json['to_longitude'].toString()),
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'order_id': orderId,
        'shipping_first_name': shippingFirstName,
        'shipping_last_name': shippingLastName,
        'shipping_email': shippingEmail,
        'shipping_phone_number': shippingPhoneNumber,
        'shipping_address': shippingAddress,
        'shipping_country': shippingCountry,
        'shipping_state': shippingState,
        'shipping_city': shippingCity,
        'shipping_zip_code': shippingZipCode,
        'billing_first_name': billingFirstName,
        'billing_last_name': billingLastName,
        'billing_email': billingEmail,
        'billing_phone_number': billingPhoneNumber,
        'billing_address': billingAddress,
        'billing_country': billingCountry,
        'billing_state': billingState,
        'billing_city': billingCity,
        'billing_zip_code': billingZipCode,
        'shipping_address_id': shippingAddressId,
        'latitude': latitude,
        'longitude': longitude,
        'fromLatitude': fromLatitude,
        'fromLongitude': fromLongitude,
        'toLatitude': toLatitude,
        'toLongitude': toLongitude
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      orderId,
      shippingFirstName,
      shippingLastName,
      shippingEmail,
      shippingPhoneNumber,
      shippingAddress,
      shippingCountry,
      shippingState,
      shippingCity,
      shippingZipCode,
      billingFirstName,
      billingLastName,
      billingEmail,
      billingPhoneNumber,
      billingAddress,
      billingCountry,
      billingState,
      billingCity,
      billingZipCode,
      shippingAddressId,
      fullname,
      phoneNumber,
      fromAddress,
      fromCountry,
      fromState,
      fromCity,
      toAddress,
      toCountry,
      toState,
      toCity,
      latitude,
      longitude,
    ];
  }
}
