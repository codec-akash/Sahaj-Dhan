import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';

class GetStocksList extends BaseUsecaseWithoutParams<List<Stock>> {
  const GetStocksList({
    required StockRepository stockRepo,
  })  : _stockRepo = stockRepo,
        super();

  final StockRepository _stockRepo;

  @override
  FutureResult<List<Stock>> call() async {
    return await _stockRepo.getStocksList();
  }
}
