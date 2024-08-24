import 'package:equatable/equatable.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';

class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends StockState {
  @override
  String toString() => 'Uninitialized';
}

class StockStateLoading extends StockState {
  final StockEvent currentEvent;

  const StockStateLoading({required this.currentEvent});
}

class StockStateFailed extends StockState {
  final StockEvent currentEvent;
  final String errorMsg;

  const StockStateFailed({
    required this.currentEvent,
    required this.errorMsg,
  });
}

class StockDealsLoaded extends StockState {
  final List<Deal> stockDeals;

  const StockDealsLoaded(this.stockDeals);
}

class PaginatedStockDealsLoaded extends StockState {
  final StockDeals stockDeals;

  const PaginatedStockDealsLoaded({required this.stockDeals});
}
