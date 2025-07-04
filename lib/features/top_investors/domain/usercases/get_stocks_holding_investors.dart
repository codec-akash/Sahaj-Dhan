import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';
import 'package:sahaj_dhan/features/top_investors/domain/repositories/top_investor_repo.dart';

class GetStocksHoldingInvestorsUsecase
    extends BaseUsecaseWithParams<List<TopInvestor>, String> {
  final TopInvestorRepo _topInvestorRepo;

  const GetStocksHoldingInvestorsUsecase(
      {required TopInvestorRepo topInvestorRepo})
      : _topInvestorRepo = topInvestorRepo;

  @override
  FutureResult<List<TopInvestor>> call(String params) {
    return _topInvestorRepo.getStocksHoldingInvestors(params);
  }
}
