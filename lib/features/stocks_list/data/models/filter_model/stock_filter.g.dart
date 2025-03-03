// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_filter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockFilterModelAdapter extends TypeAdapter<StockFilterModel> {
  @override
  final int typeId = 1;

  @override
  StockFilterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockFilterModel(
      securityName: fields[0] as String,
      symbol: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StockFilterModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.securityName)
      ..writeByte(1)
      ..write(obj.symbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockFilterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
