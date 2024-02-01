/// status : true
/// item : "Cập nhật đơn thành công"

class ResponseMessage {
  ResponseMessage({
      bool? status, 
      String? item,}){
    _status = status;
    _item = item;
}

  ResponseMessage.fromJson(dynamic json) {
    _status = json['status'];
    _item = json['item'];
  }
  bool? _status;
  String? _item;
ResponseMessage copyWith({  bool? status,
  String? item,
}) => ResponseMessage(  status: status ?? _status,
  item: item ?? _item,
);
  bool? get status => _status;
  String? get item => _item;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['item'] = _item;
    return map;
  }

}