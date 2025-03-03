import 'package:flutter/material.dart';

import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';

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

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'symbol': symbol,
      'securityName': securityName,
      'clientName': clientName,
      'tradeType': tradeType,
      'quantityTraded': quantityTraded,
      'tradePrice': tradePrice,
      'remarks': remark,
    };
  }

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
