import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';

class LongTermStockService {
  Map<String, List<LongTermStock>> mapToDateTimeStocks(
      List<LongTermStock> stocks) {
    final Map<String, List<LongTermStock>> mappedStocks = {};

    for (final stock in stocks) {
      final String dateKey = stock.initialBuyDate; // Get date part only

      if (!mappedStocks.containsKey(dateKey)) {
        mappedStocks[dateKey] = [];
      }

      mappedStocks[dateKey]!.add(stock);
    }

    return mappedStocks;
  }
}
