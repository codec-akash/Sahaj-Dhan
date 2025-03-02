import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';

class GetStocksList extends BaseUsecaseWithParams<List<Stock>, int> {
  const GetStocksList({
    required StocksRepository stockRepo,
  })  : _stockRepo = stockRepo,
        super();

  final StocksRepository _stockRepo;

  @override
  FutureResult<List<Stock>> call(params) async {
    return await _stockRepo.getStocksList(page: params);
  }
}
