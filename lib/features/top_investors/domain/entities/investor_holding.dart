import 'package:equatable/equatable.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';

class InvestorHolding extends Equatable {
  final InvestorMetrics investorMetrics;
  final List<LongTermStock> investorHoldingData;

  const InvestorHolding({
    required this.investorMetrics,
    required this.investorHoldingData,
  });

  @override
  List<Object?> get props => [investorMetrics, investorHoldingData];
}

class InvestorMetrics extends Equatable {
  final int totalTrades;
  final int profitableTrades;
  final int lossTrades;
  final double avgProfitLossRatio;

  const InvestorMetrics({
    required this.totalTrades,
    required this.profitableTrades,
    required this.lossTrades,
    required this.avgProfitLossRatio,
  });

  @override
  List<Object?> get props =>
      [totalTrades, profitableTrades, lossTrades, avgProfitLossRatio];
}
