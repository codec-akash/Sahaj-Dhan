import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/repositories/long_term_stocks_repo.dart';

class GetLongTermStocksUsecase extends BaseUsecaseWithParams<
    List<LongTermStock>, GetLongTermStocksUsecaseParams> {
  final LongTermStocksRepo _longTermStocksRepo;

  const GetLongTermStocksUsecase(this._longTermStocksRepo) : super();

  @override
  FutureResult<List<LongTermStock>> call(
      GetLongTermStocksUsecaseParams params) {
    return _longTermStocksRepo.getLongTermStocksList(
      isHistorical: params.isHistorical,
      page: params.page,
      profitType: params.profitType,
      showHighestSort: params.showHighestSort,
      monthlySortType: params.monthlySortType,
    );
  }
}

class GetLongTermStocksUsecaseParams {
  final bool isHistorical;
  final int page;
  final bool? profitType;
  final bool? monthlySortType;
  final bool? showHighestSort;

  const GetLongTermStocksUsecaseParams({
    required this.isHistorical,
    required this.page,
    this.profitType,
    this.monthlySortType,
    this.showHighestSort,
  });
}
