part of 'top_investor_bloc.dart';

class TopInvestorState extends Equatable {
  const TopInvestorState();
  @override
  List<Object?> get props => [];
}

class TopInvestorInitialState extends TopInvestorState {}

class TopInvestorLoadingState extends TopInvestorState {
  final TopInvestorEvent topInvestorEvent;

  const TopInvestorLoadingState({required this.topInvestorEvent});
}

class TopInvestorFailedState extends TopInvestorState {
  final String message;
  final TopInvestorEvent topInvestorEvent;

  const TopInvestorFailedState(this.message, this.topInvestorEvent);

  @override
  List<Object?> get props => [message];
}

class TopInvestorLoadedState extends TopInvestorState {
  final List<TopInvestor> topInvestors;

  const TopInvestorLoadedState(this.topInvestors);

  @override
  List<Object?> get props => [topInvestors];
}

class InvestorHoldingLoaded extends TopInvestorState {
  final InvestorHolding investorHolding;

  const InvestorHoldingLoaded(this.investorHolding);
}
