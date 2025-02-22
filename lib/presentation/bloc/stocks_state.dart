part of 'stocks_bloc.dart';

class StocksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StockInitialState extends StocksState {}

class StocksLoadingState extends StocksState {}

class StocksListLoaded extends StocksState {
  final List<Stock> stocks;

  StocksListLoaded({required this.stocks});

  @override
  List<Object?> get props => stocks.map((stock) => stock.id).toList();
}

class StocksFailure extends StocksState {
  final String message;

  StocksFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
