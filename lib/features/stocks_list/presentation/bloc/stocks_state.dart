part of 'stocks_bloc.dart';

abstract class StocksState extends Equatable {
  const StocksState();

  @override
  List<Object?> get props => [];
}

class StockInitialState extends StocksState {}

class StocksLoadingState extends StocksState {}

class StocksListLoaded extends StocksState {
  final Map<String, List<Stock>> stocks;

  const StocksListLoaded({required this.stocks});

  @override
  List<Object?> get props => [stocks];
}

class StockFilterLoaded extends StocksState {
  final Filter filter;

  const StockFilterLoaded(this.filter);

  @override
  List<Object?> get props => [filter];
}

class StocksFailure extends StocksState {
  final String message;
  final StocksEvent event;

  const StocksFailure({
    required this.event,
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
