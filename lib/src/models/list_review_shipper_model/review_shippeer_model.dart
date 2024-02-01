import 'member_obj.dart';

class ReviewShipperModel {
  String? id;
  String? shipperId;
  String? dvgh;
  String? userId;
  String? rating;
  String? review;
  String? ipAddress;
  String? createdAt;
  String? orderId;
  String? videoId;
  String? userUsername;
  String? userSlug;
  MemberObj? memberObj;

  ReviewShipperModel({
    this.id,
    this.shipperId,
    this.dvgh,
    this.userId,
    this.rating,
    this.review,
    this.ipAddress,
    this.createdAt,
    this.orderId,
    this.videoId,
    this.userUsername,
    this.userSlug,
    this.memberObj,
  });

  factory ReviewShipperModel.fromJson(Map<String, dynamic> json) => ReviewShipperModel(
        id: json['id'] as String?,
        shipperId: json['shipper_id'] as String?,
        dvgh: json['dvgh'] as String?,
        userId: json['user_id'] as String?,
        rating: json['rating'] as String?,
        review: json['review'] as String?,
        ipAddress: json['ip_address'] as String?,
        createdAt: json['created_at'] as String?,
        orderId: json['order_id'] as String?,
        videoId: json['video_id'] as String?,
        userUsername: json['user_username'] as String?,
        userSlug: json['user_slug'] as String?,
        memberObj: json['member_obj'] == null
            ? null
            : MemberObj.fromJson(json['member_obj'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'shipper_id': shipperId,
        'dvgh': dvgh,
        'user_id': userId,
        'rating': rating,
        'review': review,
        'ip_address': ipAddress,
        'created_at': createdAt,
        'order_id': orderId,
        'video_id': videoId,
        'user_username': userUsername,
        'user_slug': userSlug,
        'member_obj': memberObj?.toJson(),
      };
}
