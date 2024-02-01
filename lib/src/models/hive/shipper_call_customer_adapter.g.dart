// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_call_customer_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShipperCallCustomerModelAdapter
    extends TypeAdapter<ShipperCallCustomerModel> {
  @override
  final int typeId = 0;

  @override
  ShipperCallCustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShipperCallCustomerModel()
      ..orderId = fields[0] as String?
      ..created = fields[1] as DateTime?
      ..isCalled = fields[2] as bool
      ..phoneNumber = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, ShipperCallCustomerModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.isCalled)
      ..writeByte(3)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShipperCallCustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
