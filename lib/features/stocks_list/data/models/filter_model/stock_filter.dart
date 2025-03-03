import 'package:hive/hive.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/filter.dart';

part 'stock_filter.g.dart';

@HiveType(typeId: 1)
class StockFilterModel extends StocksFilter {
  const StockFilterModel({
    required this.securityName,
    required this.symbol,
  }) : super(securityName: securityName, symbol: symbol);

  @HiveField(0)
  final String securityName;
  @HiveField(1)
  final String symbol;

  factory StockFilterModel.fromJson(Map<String, dynamic> json) {
    return StockFilterModel(
      securityName: json['securityName'],
      symbol: json['symbol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'securityName': securityName,
    };
  }
}
