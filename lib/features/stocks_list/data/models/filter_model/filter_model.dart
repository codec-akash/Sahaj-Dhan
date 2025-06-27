import 'package:hive/hive.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/filter.dart';

part 'filter_model.g.dart';

@HiveType(typeId: 0)
class FilterModel extends Filter {
  const FilterModel({
    required this.clientName,
    required this.stocksFilter,
    required this.tradeType,
  }) : super(
          clientName: clientName,
          stocksFilter: stocksFilter,
          tradeType: tradeType,
        );

  @override
  @HiveField(0)
  final List<String> clientName;
  @override
  @HiveField(1)
  final List<StocksFilter> stocksFilter;
  @override
  @HiveField(2)
  final List<String> tradeType;

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      clientName: (json['clientName'] as List<dynamic>).cast<String>(),
      stocksFilter: (json['stocks'] as List<dynamic>)
          .map((e) => StocksFilter(
                securityName: e['securityName'] as String,
                symbol: e['symbol'] as String,
              ))
          .toList(),
      tradeType: (json['tradeType'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'stocksFilter': stocksFilter
          .map((filter) => {
                'securityName': filter.securityName,
                'symbol': filter.symbol,
              })
          .toList(),
      'tradeType': tradeType,
    };
  }
}
