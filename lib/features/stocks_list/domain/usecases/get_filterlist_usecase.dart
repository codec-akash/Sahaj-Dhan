import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/filter.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';

class GetFilterlistUsecase extends BaseUsecaseWithoutParams<Filter> {
  final StocksRepository _stocksRepository;

  GetFilterlistUsecase({
    required StocksRepository stocksRepository,
  })  : _stocksRepository = stocksRepository,
        super();

  @override
  FutureResult<Filter> call() {
    return _stocksRepository.getStockFilter();
  }
}
