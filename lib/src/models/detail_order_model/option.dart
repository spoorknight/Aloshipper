import 'package:equatable/equatable.dart';

class Option extends Equatable {
  final String? id;
  final String? name;
  final int? price;

  const Option({this.id, this.name, this.price});

  factory Option.fromJson(Map<String, Object?> json) => Option(
        id: json['id'] as String?,
        name: json['name'] as String?,
        price: json['price'] as int?,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'price': price,
      };

  Option copyWith({
    String? id,
    String? name,
    int? price,
  }) {
    return Option(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, price];
}
