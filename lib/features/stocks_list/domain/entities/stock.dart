import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:sahaj_dhan/core/types/stock_deal_type.dart';

part 'stock.g.dart';

@HiveType(typeId: 2)
class Stock extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String symbol;
  @HiveField(3)
  final String securityName;
  @HiveField(4)
  final String clientName;
  @HiveField(5)
  final String tradeType;
  @HiveField(6)
  final int quantityTraded;
  @HiveField(7)
  final String tradePrice;
  @HiveField(8)
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
