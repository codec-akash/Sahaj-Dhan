import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final List<String> clientName;
  final List<StocksFilter> stocksFilter;
  final List<String> tradeType;

  const Filter({
    required this.clientName,
    required this.stocksFilter,
    required this.tradeType,
  });

  @override
  List<Object?> get props => [clientName, stocksFilter, tradeType];
}

class StocksFilter extends Equatable {
  final String symbol;
  final String securityName;

  const StocksFilter({
    required this.securityName,
    required this.symbol,
  });

  @override
  List<Object?> get props => [securityName, symbol];
}
