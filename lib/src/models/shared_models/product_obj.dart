import 'package:equatable/equatable.dart';

class ProductObj extends Equatable {
  final String? id;
  final String? posbasicId;
  final String? title;
  final String? sku;
  final String? sellerId;
  final String? slug;
  final String? productType;
  final String? listingType;
  final String? url;
  final String? images;
  final int? price;
  final int? priceOld;
  final int? rating;
  final int? stockAll;
  final int? categoryId;
  final int? categoryApiId;

  const ProductObj({
    this.id,
    this.posbasicId,
    this.title,
    this.sku,
    this.sellerId,
    this.slug,
    this.productType,
    this.listingType,
    this.url,
    this.images,
    this.price,
    this.priceOld,
    this.rating,
    this.stockAll,
    this.categoryId,
    this.categoryApiId,
  });

  factory ProductObj.fromJson(Map<String, Object?> json) => ProductObj(
        id: json['id'] as String?,
        posbasicId: json['posbasic_id'] as String?,
        title: json['title'] as String?,
        sku: json['sku'] as String?,
        sellerId: json['seller_id'] as String?,
        slug: json['slug'] as String?,
        productType: json['product_type'] as String?,
        listingType: json['listing_type'] as String?,
        url: json['url'] as String?,
        images: json['images'] as String?,
        price: json['price'] as int?,
        priceOld: json['price_old'] as int?,
        rating: json['rating'] as int?,
        stockAll: json['stock_all'] as int?,
        categoryId: json['category_id'] as int?,
        categoryApiId: json['category_api_id'] as int?,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'posbasic_id': posbasicId,
        'title': title,
        'sku': sku,
        'seller_id': sellerId,
        'slug': slug,
        'product_type': productType,
        'listing_type': listingType,
        'url': url,
        'images': images,
        'price': price,
        'price_old': priceOld,
        'rating': rating,
        'stock_all': stockAll,
        'category_id': categoryId,
        'category_api_id': categoryApiId,
      };

  ProductObj copyWith({
    String? id,
    String? posbasicId,
    String? title,
    String? sku,
    String? sellerId,
    String? slug,
    String? productType,
    String? listingType,
    String? url,
    String? images,
    int? price,
    int? priceOld,
    int? rating,
    int? stockAll,
    int? categoryId,
    int? categoryApiId,
  }) {
    return ProductObj(
      id: id ?? this.id,
      posbasicId: posbasicId ?? this.posbasicId,
      title: title ?? this.title,
      sku: sku ?? this.sku,
      sellerId: sellerId ?? this.sellerId,
      slug: slug ?? this.slug,
      productType: productType ?? this.productType,
      listingType: listingType ?? this.listingType,
      url: url ?? this.url,
      images: images ?? this.images,
      price: price ?? this.price,
      priceOld: priceOld ?? this.priceOld,
      rating: rating ?? this.rating,
      stockAll: stockAll ?? this.stockAll,
      categoryId: categoryId ?? this.categoryId,
      categoryApiId: categoryApiId ?? this.categoryApiId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      posbasicId,
      title,
      sku,
      sellerId,
      slug,
      productType,
      listingType,
      url,
      images,
      price,
      priceOld,
      rating,
      stockAll,
      categoryId,
      categoryApiId,
    ];
  }
}
