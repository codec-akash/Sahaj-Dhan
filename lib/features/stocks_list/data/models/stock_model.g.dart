// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockModel _$StockModelFromJson(Map<String, dynamic> json) => StockModel(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
      symbol: json['symbol'] as String,
      securityName: json['securityName'] as String,
      clientName: json['clientName'] as String,
      tradeType: json['tradeType'] as String,
      quantityTraded: (json['quantityTraded'] as num).toInt(),
      tradePrice: json['tradePrice'] as String,
      remark: json['remarks'] as String,
    );

Map<String, dynamic> _$StockModelToJson(StockModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'symbol': instance.symbol,
      'securityName': instance.securityName,
      'clientName': instance.clientName,
      'tradeType': instance.tradeType,
      'quantityTraded': instance.quantityTraded,
      'tradePrice': instance.tradePrice,
      'remarks': instance.remark,
    };
