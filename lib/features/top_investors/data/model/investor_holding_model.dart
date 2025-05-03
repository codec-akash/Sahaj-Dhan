import 'package:sahaj_dhan/features/long_term_stocks/data/model/long_term_holding_model.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/investor_holding.dart';

class InvestorHoldingModel extends InvestorHolding {
  const InvestorHoldingModel({
    required super.investorMetrics,
    required super.investorHoldingData,
  });

  factory InvestorHoldingModel.fromJson(Map<String, dynamic> json) {
    return InvestorHoldingModel(
      investorMetrics: InvestorMetricsModel.fromJson(json['investorMetrics']),
      investorHoldingData: (json['data'] as List)
          .map((elementJson) => LongTermHoldingModel.fromJson(elementJson))
          .toList(),
    );
  }
}

class InvestorMetricsModel extends InvestorMetrics {
  const InvestorMetricsModel({
    required super.totalTrades,
    required super.profitableTrades,
    required super.lossTrades,
    required super.avgProfitLossRatio,
  });

  factory InvestorMetricsModel.fromJson(Map<String, dynamic> json) {
    return InvestorMetricsModel(
      totalTrades: json['totalTrades'],
      profitableTrades: json['profitableTrades'],
      lossTrades: json['lossTrades'],
      avgProfitLossRatio: json['avgProfitLossRatio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalTrades': totalTrades,
      'profitableTrades': profitableTrades,
      'lossTrades': lossTrades,
      'avgProfitLossRatio': avgProfitLossRatio,
    };
  }
}
