import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';

class LongTermHoldingModel extends LongTermStock {
  const LongTermHoldingModel({
    required super.id,
    required super.clientName,
    required super.symbol,
    required super.securityName,
    required super.initialBuyDate,
    required super.quantity,
    required super.averageBuyPrice,
    required super.latestPrice,
    required super.status,
    required super.isLongTerm,
    required super.gainLossPercentage,
    required super.holdingDuration,
    required super.closedDate,
    required super.closedPrice,
    required super.createdAt,
    required super.updatedAt,
  });

  factory LongTermHoldingModel.fromJson(Map<String, dynamic> json) =>
      LongTermHoldingModel(
        id: json['id'],
        clientName: json['clientName'],
        symbol: json['symbol'],
        securityName: json['securityName'],
        initialBuyDate: json['initialBuyDate'],
        quantity: json['quantity'],
        averageBuyPrice: json['averageBuyPrice'],
        latestPrice: json['latestPrice'],
        status: json['status'],
        isLongTerm: json['isLongTerm'] == 1,
        gainLossPercentage: double.tryParse(json['gainLossPercentage']) ?? 0,
        holdingDuration: json['holdingDuration'],
        closedDate: json['closedDate'],
        closedPrice: json['closedPrice'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'symbol': symbol,
      'securityName': securityName,
      'initialBuyDate': initialBuyDate,
      'quantity': quantity,
      'averageBuyPrice': averageBuyPrice,
      'latestPrice': latestPrice,
      'status': status,
      'isLongTerm': isLongTerm,
      'gainLossPercentage': gainLossPercentage,
      'holdingDuration': holdingDuration,
      'closedDate': closedDate,
      'closedPrice': closedPrice,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  LongTermHoldingModel copyWith({
    int? id,
    String? clientName,
    String? symbol,
    String? securityName,
    String? initialBuyDate,
    int? quantity,
    String? averageBuyPrice,
    String? latestPrice,
    String? status,
    bool? isLongTerm,
    double? gainLossPercentage,
    int? holdingDuration,
    String? closedDate,
    String? closedPrice,
    String? createdAt,
    String? updatedAt,
  }) {
    return LongTermHoldingModel(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      symbol: symbol ?? this.symbol,
      securityName: securityName ?? this.securityName,
      initialBuyDate: initialBuyDate ?? this.initialBuyDate,
      quantity: quantity ?? this.quantity,
      averageBuyPrice: averageBuyPrice ?? this.averageBuyPrice,
      latestPrice: latestPrice ?? this.latestPrice,
      status: status ?? this.status,
      isLongTerm: isLongTerm ?? this.isLongTerm,
      gainLossPercentage: gainLossPercentage ?? this.gainLossPercentage,
      holdingDuration: holdingDuration ?? this.holdingDuration,
      closedDate: closedDate ?? this.closedDate,
      closedPrice: closedPrice ?? this.closedPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
