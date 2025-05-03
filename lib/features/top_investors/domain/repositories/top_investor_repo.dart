import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/investor_holding.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';

abstract class TopInvestorRepo {
  FutureResult<List<TopInvestor>> getTopInvestors();

  FutureResult<InvestorHolding> getInvestorHoldings(String clientName);
}
