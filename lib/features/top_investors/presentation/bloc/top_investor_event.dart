part of 'top_investor_bloc.dart';

class TopInvestorEvent extends Equatable {
  const TopInvestorEvent();
  @override
  List<Object?> get props => [];
}

class LoadTopInvestors extends TopInvestorEvent {}

class LoadInvestorHoldings extends TopInvestorEvent {
  final String clientName;

  const LoadInvestorHoldings(this.clientName);

  @override
  List<Object?> get props => [clientName];
}
