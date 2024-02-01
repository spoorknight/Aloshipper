import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? title;
  final int? price;
  final String? quantity;
  final String? sku;

  const Product({this.title, this.price, this.quantity, this.sku});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json['title'] as String?,
        price: json['price'] as int?,
        quantity: json['quantity'] as String?,
        sku: json['sku'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'quantity': quantity,
        'sku': sku,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [title, price, quantity, sku];
}
