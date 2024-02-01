import 'package:equatable/equatable.dart';

import '../detail_order_model/khuyenmai.dart';
import '../detail_order_model/option.dart';
import 'product_obj.dart';

class Product extends Equatable {
  final String? id;
  final String? titleOrder;
  final String? title;
  final double? price;
  final String? quantity;
  final double? totalPrice;
  final List<Option>? options;
  final String? priceOptionAll;
  final Khuyenmai? khuyenmai;
  final String? orderGhichu;
  final ProductObj? productObj;

  final String? posbasicId;

  final String? sku;
  final String? sellerId;
  final String? slug;
  final String? productType;
  final String? listingType;
  final String? url;
  final String? images;

  final double? priceOld;
  final int? rating;
  final int? stockAll;
  final int? stock;
  final bool? choPhepBanAm;
  final int? discountRate;

  final int? categoryId;
  final int? categoryApiId;

  const Product({
    this.id,
    this.titleOrder,
    this.title,
    this.price,
    this.quantity,
    this.totalPrice,
    this.options,
    this.priceOptionAll,
    this.khuyenmai,
    this.orderGhichu,
    this.productObj,
    this.posbasicId,
    this.sku,
    this.sellerId,
    this.slug,
    this.productType,
    this.listingType,
    this.url,
    this.images,
    this.priceOld,
    this.rating,
    this.stockAll,
    this.stock,
    this.choPhepBanAm,
    this.discountRate,
    this.categoryId,
    this.categoryApiId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String?,
        titleOrder: json['title_order'] as String?,
        title: json['title'] as String?,
        price: double.tryParse(json['price'].toString()),
        quantity: json['quantity'] as String?,
        totalPrice: double.tryParse(json['total_price'].toString()),
        options: (json['options'] as List<dynamic>?)?.map((e) => Option.fromJson(e as Map<String, Object?>)).toList(),
        priceOptionAll: json['price_option_all'] as String?,
        khuyenmai: json['khuyenmai'] == null ? null : Khuyenmai.fromJson(json['khuyenmai']! as Map<String, Object?>),
        orderGhichu: json['order_ghichu'] as String?,
        productObj:
            json['product_obj'] == null ? null : ProductObj.fromJson(json['product_obj']! as Map<String, Object?>),
        posbasicId: json['posbasic_id'] as String?,
        sku: json['sku'] as String?,
        sellerId: json['seller_id'] as String?,
        slug: json['slug'] as String?,
        productType: json['product_type'] as String?,
        listingType: json['listing_type'] as String?,
        url: json['url'] as String?,
        images: json['images'] as String?,
        priceOld: double.tryParse(json['price_old'].toString()),
        rating: json['rating'] as int?,
        stockAll: json['stock_all'] as int?,
        stock: json['stock'] as int?,
        choPhepBanAm: json['cho_phep_ban_am'] as bool?,
        discountRate: json['discount_rate'] as int?,
        categoryId: json['category_id'] as int?,
        categoryApiId: json['category_api_id'] as int?,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'title_order': titleOrder,
        'title': title,
        'price': price,
        'quantity': quantity,
        'total_price': totalPrice,
        'options': options?.map((e) => e.toJson()).toList(),
        'price_option_all': priceOptionAll,
        'khuyenmai': khuyenmai?.toJson(),
        'order_ghichu': orderGhichu,
        'product_obj': productObj?.toJson(),
        'posbasic_id': posbasicId,
        'sku': sku,
        'seller_id': sellerId,
        'slug': slug,
        'product_type': productType,
        'listing_type': listingType,
        'url': url,
        'images': images,
        'price_old': priceOld,
        'rating': rating,
        'stock_all': stockAll,
        'stock': stock,
        'cho_phep_ban_am': choPhepBanAm,
        'discount_rate': discountRate,
        'category_id': categoryId,
        'category_api_id': categoryApiId,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      titleOrder,
      title,
      price,
      quantity,
      totalPrice,
      options,
      priceOptionAll,
      khuyenmai,
      orderGhichu,
      productObj,
      posbasicId,
      sku,
      sellerId,
      slug,
      productType,
      listingType,
      url,
      images,
      priceOld,
      rating,
      stockAll,
      stock,
      choPhepBanAm,
      discountRate,
      categoryId,
      categoryApiId,
    ];
  }

  String get getOptionsName {
    String result = '';
    if (options?.isNotEmpty ?? false) {
      for (int index = 0; index < (options!.length); index++) {
        if (index == 0) {
          result = options![index].name ?? '';
        } else {
          result = '$result, ${options![index].name}';
        }
      }
    }
    return result;
  }

  double get getTotalPriceOptions {
    double result = 0;
    if (options?.isNotEmpty ?? false) {
      for (int index = 0; index < (options!.length); index++) {
        result += double.parse((options![index].price ?? 0).toString());
      }
    }
    return result * (int.tryParse(quantity ?? '0') ?? 0);
  }
}
