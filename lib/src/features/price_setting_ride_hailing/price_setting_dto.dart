/// ride_hailing_fee_id : 1
/// fee : 9000

class PriceSettingDTO {
  PriceSettingDTO({
      this.rideHailingFeeId, 
      this.fee,});

  PriceSettingDTO.fromJson(dynamic json) {
    rideHailingFeeId = json['ride_hailing_fee_id'];
    fee = json['fee'];
  }
  int? rideHailingFeeId;
  int? fee;
PriceSettingDTO copyWith({  int? rideHailingFeeId,
  int? fee,
}) => PriceSettingDTO(  rideHailingFeeId: rideHailingFeeId ?? this.rideHailingFeeId,
  fee: fee ?? this.fee,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ride_hailing_fee_id'] = rideHailingFeeId;
    map['fee'] = fee;
    return map;
  }

}