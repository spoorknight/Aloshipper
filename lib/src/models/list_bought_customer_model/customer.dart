import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String? phoneNumber;
  final String? fullname;

  const Customer({this.phoneNumber, this.fullname});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        phoneNumber: json['phone_number'] as String?,
        fullname: json['fullname'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'phone_number': phoneNumber,
        'fullname': fullname,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [phoneNumber, fullname];
}
