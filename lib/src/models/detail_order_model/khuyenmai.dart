import 'package:equatable/equatable.dart';

class Khuyenmai extends Equatable {
  final String? price;
  final String? giakm;
  final String? phantram;
  final String? title;
  final String? kmid;
  final String? productIdTang;

  const Khuyenmai({
    this.price,
    this.giakm,
    this.phantram,
    this.title,
    this.kmid,
    this.productIdTang,
  });

  factory Khuyenmai.fromJson(Map<String, Object?> json) => Khuyenmai(
        price: json['price'].toString(),
        giakm: json['giakm'].toString(),
        phantram: json['phantram'].toString(),
        title: json['title'].toString(),
        kmid: json['kmid'].toString(),
        productIdTang: json['product_id_tang'].toString(),
      );

  Map<String, Object?> toJson() => {
        'price': price,
        'giakm': giakm,
        'phantram': phantram,
        'title': title,
        'kmid': kmid,
        'product_id_tang': productIdTang,
      };

  Khuyenmai copyWith({
    String? price,
    String? giakm,
    String? phantram,
    String? title,
    String? kmid,
    String? productIdTang,
  }) {
    return Khuyenmai(
      price: price ?? this.price,
      giakm: giakm ?? this.giakm,
      phantram: phantram ?? this.phantram,
      title: title ?? this.title,
      kmid: kmid ?? this.kmid,
      productIdTang: productIdTang ?? this.productIdTang,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [price, giakm, phantram, title, kmid, productIdTang];
}
