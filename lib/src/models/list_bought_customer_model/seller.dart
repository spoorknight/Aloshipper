import 'package:equatable/equatable.dart';

class Seller extends Equatable {
  final String? shopName;
  final String? phoneNumber;
  final String? fullname;

  const Seller({this.shopName, this.phoneNumber, this.fullname});

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        shopName: json['shop_name'] as String?,
        phoneNumber: json['phone_number'] as String?,
        fullname: json['fullname'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'shop_name': shopName,
        'phone_number': phoneNumber,
        'fullname': fullname,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [shopName, phoneNumber, fullname];
}
