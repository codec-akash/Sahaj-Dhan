import 'package:equatable/equatable.dart';

class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class LoadStockDeals extends StockEvent {
  final String? tradeType;
  final String? skip;
  final String? limit;

  const LoadStockDeals({
    this.tradeType,
    this.limit,
    this.skip,
  });

  @override
  List<Object> get props => [];
}

class LoadPaginationStockDeal extends StockEvent {
  final int skip;
  final bool isEndOfList;
  final String? symbolName;
  final String? tradeTypes;
  final DateTime? executedAt;

  const LoadPaginationStockDeal({
    required this.skip,
    required this.isEndOfList,
    this.symbolName,
    this.tradeTypes,
    this.executedAt,
  });

  @override
  List<Object> get props => [skip, isEndOfList];
}

class LoadStockDealFilters extends StockEvent {}
