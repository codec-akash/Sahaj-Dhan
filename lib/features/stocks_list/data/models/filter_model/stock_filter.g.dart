// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockFilterModel _$StockFilterModelFromJson(Map<String, dynamic> json) =>
    StockFilterModel(
      securityName: json['securityName'] as String,
      symbol: json['symbol'] as String,
    );

Map<String, dynamic> _$StockFilterModelToJson(StockFilterModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'securityName': instance.securityName,
    };
