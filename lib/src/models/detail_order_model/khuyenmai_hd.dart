import 'package:equatable/equatable.dart';

class KhuyenmaiHd extends Equatable {
  final String? id;
  final String? storeId;
  final String? title;
  final String? groupId;
  final String? batdau;
  final String? ketthuc;
  final String? type;
  final String? val;
  final String? created;
  final String? userInit;
  final String? userUpd;
  final String? updated;
  final dynamic ghichu;
  final String? discount;
  final String? discountType;

  const KhuyenmaiHd({
    this.id,
    this.storeId,
    this.title,
    this.groupId,
    this.batdau,
    this.ketthuc,
    this.type,
    this.val,
    this.created,
    this.userInit,
    this.userUpd,
    this.updated,
    this.ghichu,
    this.discount,
    this.discountType,
  });

  factory KhuyenmaiHd.fromJson(Map<String, Object?> json) => KhuyenmaiHd(
        id: json['ID'] as String?,
        storeId: json['store_id'] as String?,
        title: json['title'] as String?,
        groupId: json['group_id'] as String?,
        batdau: json['batdau'] as String?,
        ketthuc: json['ketthuc'] as String?,
        type: json['type'] as String?,
        val: json['val'] as String?,
        created: json['created'] as String?,
        userInit: json['user_init'] as String?,
        userUpd: json['user_upd'] as String?,
        updated: json['updated'] as String?,
        ghichu: json['ghichu'] as dynamic,
        discount: json['discount'] as String?,
        discountType: json['discount_type'] as String?,
      );

  Map<String, Object?> toJson() => {
        'ID': id,
        'store_id': storeId,
        'title': title,
        'group_id': groupId,
        'batdau': batdau,
        'ketthuc': ketthuc,
        'type': type,
        'val': val,
        'created': created,
        'user_init': userInit,
        'user_upd': userUpd,
        'updated': updated,
        'ghichu': ghichu,
        'discount': discount,
        'discount_type': discountType,
      };

  KhuyenmaiHd copyWith({
    String? id,
    String? storeId,
    String? title,
    String? groupId,
    String? batdau,
    String? ketthuc,
    String? type,
    String? val,
    String? created,
    String? userInit,
    String? userUpd,
    String? updated,
    dynamic ghichu,
    String? discount,
    String? discountType,
  }) {
    return KhuyenmaiHd(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      title: title ?? this.title,
      groupId: groupId ?? this.groupId,
      batdau: batdau ?? this.batdau,
      ketthuc: ketthuc ?? this.ketthuc,
      type: type ?? this.type,
      val: val ?? this.val,
      created: created ?? this.created,
      userInit: userInit ?? this.userInit,
      userUpd: userUpd ?? this.userUpd,
      updated: updated ?? this.updated,
      ghichu: ghichu ?? this.ghichu,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      storeId,
      title,
      groupId,
      batdau,
      ketthuc,
      type,
      val,
      created,
      userInit,
      userUpd,
      updated,
      ghichu,
      discount,
      discountType,
    ];
  }
}
