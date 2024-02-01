import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String? linkDieukhoan;
  final String? hoahong;
  final int? thunhapMoshop;
  final int? hoahongSanpham;
  final String? maGioiThieu;
  final String? linkGioiThieu;

  const Item({
    this.linkDieukhoan,
    this.hoahong,
    this.thunhapMoshop,
    this.hoahongSanpham,
    this.maGioiThieu,
    this.linkGioiThieu,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        linkDieukhoan: json['link_dieukhoan'] as String?,
        hoahong: json['hoahong'] as String?,
        thunhapMoshop: json['thunhap_moshop'] as int?,
        hoahongSanpham: json['hoahong_sanpham'] as int?,
        maGioiThieu: json['ma_gioi_thieu'] as String?,
        linkGioiThieu: json['link_gioi_thieu'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'link_dieukhoan': linkDieukhoan,
        'hoahong': hoahong,
        'thunhap_moshop': thunhapMoshop,
        'hoahong_sanpham': hoahongSanpham,
        'ma_gioi_thieu': maGioiThieu,
        'link_gioi_thieu': linkGioiThieu,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      linkDieukhoan,
      hoahong,
      thunhapMoshop,
      hoahongSanpham,
      maGioiThieu,
      linkGioiThieu,
    ];
  }
}
