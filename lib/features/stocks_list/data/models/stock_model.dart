import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';

part 'stock_model.g.dart';

@JsonSerializable()
class StockModel extends Stock {
  const StockModel({
    required super.id,
    required super.date,
    required super.symbol,
    required super.securityName,
    required super.clientName,
    required super.tradeType,
    required super.quantityTraded,
    required super.tradePrice,
    required super.remark,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$StockModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockModelToJson(this);

  @visibleForTesting
  const StockModel.empty()
      : this(
          id: 1,
          date: '_empty.date',
          symbol: '_empty.symbol',
          securityName: '_empty.securityName',
          clientName: '_empty.clientName',
          tradeType: '_empty.tradeType',
          quantityTraded: 1,
          tradePrice: '_empty.tradePrice',
          remark: '_empty.remark',
        );

  StockModel copyWith({
    String? date,
    String? symbol,
    String? securityName,
    String? clientName,
    String? tradeType,
    int? quantityTraded,
    String? tradePrice,
    String? remark,
  }) {
    return StockModel(
      id: id,
      date: date ?? this.date,
      symbol: symbol ?? this.symbol,
      securityName: securityName ?? this.securityName,
      clientName: clientName ?? this.clientName,
      tradeType: tradeType ?? this.tradeType,
      quantityTraded: quantityTraded ?? this.quantityTraded,
      tradePrice: tradePrice ?? this.tradePrice,
      remark: remark ?? this.remark,
    );
  }
}
