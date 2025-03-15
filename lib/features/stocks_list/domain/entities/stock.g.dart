// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockAdapter extends TypeAdapter<Stock> {
  @override
  final int typeId = 2;

  @override
  Stock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stock(
      id: fields[0] as int,
      date: fields[1] as String,
      symbol: fields[2] as String,
      securityName: fields[3] as String,
      clientName: fields[4] as String,
      tradeType: fields[5] as String,
      quantityTraded: fields[6] as int,
      tradePrice: fields[7] as String,
      remark: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Stock obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.securityName)
      ..writeByte(4)
      ..write(obj.clientName)
      ..writeByte(5)
      ..write(obj.tradeType)
      ..writeByte(6)
      ..write(obj.quantityTraded)
      ..writeByte(7)
      ..write(obj.tradePrice)
      ..writeByte(8)
      ..write(obj.remark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
