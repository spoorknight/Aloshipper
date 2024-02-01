import 'package:equatable/equatable.dart';

import 'customer.dart';
import 'product.dart';
import 'seller.dart';

class BoughtCustomerModel extends Equatable {
  final String? id;
  final int? hoahong;
  final String? statusText;
  final String? createdAt;
  final Product? product;
  final Seller? seller;
  final Customer? customer;

  const BoughtCustomerModel({
    this.id,
    this.hoahong,
    this.statusText,
    this.createdAt,
    this.product,
    this.seller,
    this.customer,
  });

  factory BoughtCustomerModel.fromJson(Map<String, dynamic> json) =>
      BoughtCustomerModel(
        id: json['id'] as String?,
        hoahong: json['hoahong'] as int?,
        statusText: json['status_text'] as String?,
        createdAt: json['created_at'] as String?,
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
        seller: json['seller'] == null
            ? null
            : Seller.fromJson(json['seller'] as Map<String, dynamic>),
        customer: json['customer'] == null
            ? null
            : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'hoahong': hoahong,
        'status_text': statusText,
        'created_at': createdAt,
        'product': product?.toJson(),
        'seller': seller?.toJson(),
        'customer': customer?.toJson(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      hoahong,
      statusText,
      createdAt,
      product,
      seller,
      customer,
    ];
  }
}
