part of 'top_investor_bloc.dart';

class TopInvestorEvent extends Equatable {
  const TopInvestorEvent();
  @override
  List<Object?> get props => [];
}

class LoadTopInvestors extends TopInvestorEvent {}

class LoadInvestorHoldings extends TopInvestorEvent {
  final String clientName;
  final String? holdingType;

  const LoadInvestorHoldings(this.clientName, {this.holdingType});

  @override
  List<Object?> get props => [clientName];
}

class LoadStocksHoldingInvestors extends TopInvestorEvent {
  final String stockName;

  const LoadStocksHoldingInvestors(this.stockName);

  @override
  List<Object?> get props => [stockName];
}
