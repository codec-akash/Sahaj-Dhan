import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';

abstract class LongTermStocksRepo {
  FutureResult<List<LongTermStock>> getLongTermStocksList({
    required bool isHistorical,
    required int page,
    bool? profitType,
    bool? monthlySortType,
    bool? showHighestSort,
  });
}
