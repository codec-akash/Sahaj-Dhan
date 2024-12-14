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
  final int page;
  final bool hasNextPage;
  final String? symbolName;
  final String? clientName;
  final String? tradeTypes;
  final DateTime? executedAt;
  final DateTime? endDate;

  const LoadPaginationStockDeal({
    required this.page,
    required this.hasNextPage,
    this.symbolName,
    this.clientName,
    this.tradeTypes,
    this.executedAt,
    this.endDate,
  });

  @override
  List<Object> get props => [page, hasNextPage];
}

class LoadStockDealFilters extends StockEvent {}
