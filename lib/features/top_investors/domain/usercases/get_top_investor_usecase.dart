import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';
import 'package:sahaj_dhan/features/top_investors/domain/repositories/top_investor_repo.dart';

class GetTopInvestorUsecase
    extends BaseUsecaseWithoutParams<List<TopInvestor>> {
  final TopInvestorRepo _topInvestorRepo;

  const GetTopInvestorUsecase(this._topInvestorRepo);

  @override
  FutureResult<List<TopInvestor>> call() {
    return _topInvestorRepo.getTopInvestors();
  }
}
