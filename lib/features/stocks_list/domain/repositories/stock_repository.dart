import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/filter.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';

abstract class StocksRepository {
  FutureResult<List<Stock>> getStocksList({required int page});

  FutureResult<Filter> getStockFilter();
}
