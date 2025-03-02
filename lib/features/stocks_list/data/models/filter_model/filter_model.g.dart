// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) => FilterModel(
      clientName: json['clientName'] == null
          ? []
          : (json['clientName'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      tradeType: json['tradeType'] == null
          ? []
          : (json['tradeType'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      stocksFilter: json['stocks'] == null
          ? []
          : (json['stocks'] as List)
              .map((element) => StockFilterModel.fromJson(element))
              .toList(),
    );

Map<String, dynamic> _$FilterModelToJson(FilterModel instance) =>
    <String, dynamic>{
      'clientName': instance.clientName,
      'tradeType': instance.tradeType,
    };
