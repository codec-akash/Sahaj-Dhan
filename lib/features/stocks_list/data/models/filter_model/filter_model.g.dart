// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterModelAdapter extends TypeAdapter<FilterModel> {
  @override
  final int typeId = 0;

  @override
  FilterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterModel(
      clientName: (fields[0] as List).cast<String>(),
      stocksFilter: (fields[1] as List).cast<StocksFilter>(),
      tradeType: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FilterModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.clientName)
      ..writeByte(1)
      ..write(obj.stocksFilter)
      ..writeByte(2)
      ..write(obj.tradeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
