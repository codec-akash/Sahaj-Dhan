import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/repositories/long_term_stocks_repo.dart';

class GetLongTermStocksUsecase extends BaseUsecaseWithParams<
    List<LongTermStocks>, GetLongTermStocksUsecaseParams> {
  final LongTermStocksRepo _longTermStocksRepo;

  const GetLongTermStocksUsecase(this._longTermStocksRepo) : super();

  @override
  FutureResult<List<LongTermStocks>> call(
      GetLongTermStocksUsecaseParams params) {
    return _longTermStocksRepo.getLongTermStocksList(
        isHistorical: params.isHistorical, page: params.page);
  }
}

class GetLongTermStocksUsecaseParams {
  final bool isHistorical;
  final int page;

  const GetLongTermStocksUsecaseParams({
    required this.isHistorical,
    required this.page,
  });
}
