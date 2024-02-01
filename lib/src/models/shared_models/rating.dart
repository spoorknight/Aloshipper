import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String? count;
  final String? rating;

  const Rating({this.count, this.rating});

  factory Rating.fromJson(Map<String, Object?> json) => Rating(
        count: json['count'].toString(),
        rating: json['rating'].toString(),
      );

  Map<String, Object?> toJson() => {
        'count': count,
        'rating': rating,
      };

  Rating copyWith({
    String? count,
    String? rating,
  }) {
    return Rating(
      count: count ?? this.count,
      rating: rating ?? this.rating,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [count, rating];
}
