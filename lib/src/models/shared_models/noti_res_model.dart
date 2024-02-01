// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotiResModel {
  String? title;
  String? body;
  String? icon;
  String? transactionId;
  String? theLoai;
  NotiResModel({
    this.title,
    this.icon,
    this.transactionId,
    this.theLoai,
    this.body,
  });

  NotiResModel copyWith({
    String? title,
    String? icon,
    String? transactionId,
    String? theLoai,
    String? body,
  }) {
    return NotiResModel(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      transactionId: transactionId ?? this.transactionId,
      theLoai: theLoai ?? this.theLoai,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'icon': icon,
      'transactionId': transactionId,
      'theloai': theLoai,
      'body': body,
    };
  }

  factory NotiResModel.fromJson(Map<String, dynamic> map) {
    return NotiResModel(
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      transactionId: map['transaction_id'] != null ? map['transaction_id'] as String : null,
      theLoai: map['theloai'] != null ? map['theloai'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'NotiResModel(title: $title, body: $body, icon: $icon, transactionId: $transactionId, theLoai: $theLoai)';
  }

  @override
  bool operator ==(covariant NotiResModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.icon == icon &&
        other.transactionId == transactionId &&
        other.theLoai == theLoai &&
        other.body == body;
  }

  @override
  int get hashCode {
    return title.hashCode ^ icon.hashCode ^ transactionId.hashCode ^ theLoai.hashCode ^ body.hashCode;
  }
}
