import 'package:equatable/equatable.dart';

class LocationObj extends Equatable {
  final String? countryId;
  final String? stateId;
  final String? cityId;

  const LocationObj({this.countryId, this.stateId, this.cityId});

  factory LocationObj.fromJson(Map<String, Object?> json) => LocationObj(
        countryId: json['country_id'] as String?,
        stateId: json['state_id'] as String?,
        cityId: json['city_id'] as String?,
      );

  Map<String, Object?> toJson() => {
        'country_id': countryId,
        'state_id': stateId,
        'city_id': cityId,
      };

  LocationObj copyWith({
    String? countryId,
    String? stateId,
    String? cityId,
  }) {
    return LocationObj(
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [countryId, stateId, cityId];
}
