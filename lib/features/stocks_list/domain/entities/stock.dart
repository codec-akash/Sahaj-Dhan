import 'package:equatable/equatable.dart';
import 'package:sahaj_dhan/core/types/stock_deal_type.dart';

class Stock extends Equatable {
  final int id;
  final String date;
  final String symbol;
  final String securityName;
  final String clientName;
  final String tradeType;
  final int quantityTraded;
  final String tradePrice;
  final String remark;

  const Stock({
    required this.id,
    required this.date,
    required this.symbol,
    required this.securityName,
    required this.clientName,
    required this.tradeType,
    required this.quantityTraded,
    required this.tradePrice,
    required this.remark,
  });

  StockDealType get stockDealType =>
      StockDealType.fromText(tradeType.toUpperCase());

  @override
  List<Object?> get props => [
        id,
        date,
        symbol,
        securityName,
        clientName,
        tradePrice,
        tradeType,
        quantityTraded,
        remark
      ];
}
