class DiscountProductModel {
  String? id;
  String? sku;
  String? url;
  String? image;
  String? title;
  String? categoryName;
  int? rating;
  int? stock;
  int? soluongConlai;
  int? chieckhau;
  String? hethan;
  String? urlAffLink;

  DiscountProductModel({
    this.id,
    this.sku,
    this.url,
    this.image,
    this.title,
    this.categoryName,
    this.rating,
    this.stock,
    this.soluongConlai,
    this.chieckhau,
    this.hethan,
    this.urlAffLink,
  });

  @override
  String toString() {
    return 'DiscountProduct(id: $id, sku: $sku, url: $url, image: $image, title: $title, categoryName: $categoryName, rating: $rating, stock: $stock, soluongConlai: $soluongConlai, chieckhau: $chieckhau, hethan: $hethan, urlAffLink: $urlAffLink)';
  }

  factory DiscountProductModel.fromJson(Map<String, dynamic> json) =>
      DiscountProductModel(
        id: json['id'] as String?,
        sku: json['sku'] as String?,
        url: json['url'] as String?,
        image: json['image'] as String?,
        title: json['title'] as String?,
        categoryName: json['category_name'] as String?,
        rating: json['rating'] as int?,
        stock: json['stock'] as int?,
        soluongConlai: json['soluong_conlai'] as int?,
        chieckhau: json['chieckhau'] as int?,
        hethan: json['hethan'] as String?,
        urlAffLink: json['url_aff_link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sku': sku,
        'url': url,
        'image': image,
        'title': title,
        'category_name': categoryName,
        'rating': rating,
        'stock': stock,
        'soluong_conlai': soluongConlai,
        'chieckhau': chieckhau,
        'hethan': hethan,
        'url_aff_link': urlAffLink,
      };
}
