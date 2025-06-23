import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/investor_holding.dart';
import 'package:sahaj_dhan/features/top_investors/domain/repositories/top_investor_repo.dart';

class GetInvestorHoldings
    extends BaseUsecaseWithParams<InvestorHolding, GetInvestorHoldingsParams> {
  final TopInvestorRepo _topInvestorRepo;

  const GetInvestorHoldings({required TopInvestorRepo topInvestorRepo})
      : _topInvestorRepo = topInvestorRepo;

  @override
  FutureResult<InvestorHolding> call(params) {
    return _topInvestorRepo.getInvestorHoldings(params.clientName,
        holdingType: params.holdingType);
  }
}

class GetInvestorHoldingsParams {
  final String clientName;
  final String? holdingType;

  const GetInvestorHoldingsParams(this.clientName, {this.holdingType});
}
